# -*- coding:utf-8; tab-width:4; mode:shell-script -*-

function is_defined {
    [ ! -z "$(eval echo \$${1})" ]
}

function assure_defined {
    if ! is_defined "$1"; then
	echo "-- You must define the $1 environment variable"
	exit
    fi
}

function _ian-assure-deb-source {
    if [ ! -d ./debian ]; then
	echo "-- There is not a ./debian directory here!"
	exit
    fi
}

function _ian-assure-deb-variables {
    assure_defined DEBFULLNAME
    assure_defined DEBEMAIL
    assure_defined GPGKEYID
    assure_defined REPOACCOUNT
    assure_defined REPOPATH
}

function _ian-preconditions {
    _ian-assure-deb-source
    _ian-assure-deb-variables
}

function ian-new-release {
    (
    _ian-preconditions
    emacs debian/changelog
    )
}

function _ian-source-name {
    grep "Source:" debian/control | cut -f2 -d:  | tr -d " "
}

function _ian-binary-names {
    grep "Package:" debian/control | cut -f2 -d:  | tr -d " "
}

function _ian-build-arch {
    dpkg-architecture | grep "DEB_BUILD_ARCH=" | head -n1 | cut -f2 -d=  | tr -d " "
}

# FIXME: each binary package may have different architecture
function _ian-control-arch {
    grep "Architecture:" debian/control | head -n1 | cut -f2 -d:  | tr -d " "
}

function _ian-binary-filenames {
    for pkg in $(_ian-binary-names); do
	echo ${pkg}_$(_ian-version)_$(_ian-control-arch).deb
    done
}

function _ian-binary-paths {
    build_path=".."
    if _ian-is-svn; then
	build_path="../build-area"
    fi

    for fname in $(_ian-binary-filenames); do
	echo $build_path/$fname
    done
}

function _ian-version {
    head -n 1 debian/changelog | cut -f2 -d " " | tr -d "()"
}

function _ian-upstream-version {
    echo $(_ian-version) | cut -f1 -d "-"
}

function _ian-orig-filename {
    echo $(_ian-source-name)_$(_ian-upstream-version).orig.tar.gz
}

function _ian-changes-filename {
    echo $(_ian-source-name)_$(_ian-version)_$(_ian-build-arch).changes
}

function _ian-changes-path {
    build_path='..'
    if _ian-is-svn; then
	build_path='../build-area'
    fi

    echo $build_path/$(_ian-changes-filename)
}

function _ian-generated-filenames {
    deb_prefix=$(_ian-source-name)_$(_ian-version)
    echo ${deb_prefix}.debian.tar.gz
    echo $deb_prefix.dsc
    _ian-changes-filename
    _ian-orig-filename
}

function _ian-is-svn {
    (svn pl debian | grep mergeWithUpstream) &> /dev/null
    return $?
}

function ian-show-content {
    (
    _ian-preconditions
    less $(_ian-binary-paths)
    )
}

function ian-vars {
    (
    _ian-preconditions
    echo "source-name: " $(_ian-source-name)
    echo "uptream:     " $(_ian-upstream-version)
    echo "version:     " $(_ian-version)
    echo "orig-file:   " $(_ian-orig-filename)
    echo "changes-file:" $(_ian-changes-filename)
    _ian-is-svn
    echo "is-svn:      " $?
    )
}



#-- build ------------------------------------------------------------

function ian-build {
    (
    _ian-preconditions
    ian-clean
    if _ian-is-svn; then
	ian-svn-build
    else
	ian-standard-build
    fi
    )
}

function ian-standard-build {
    (
    _ian-preconditions
    ian-get-orig ..
    dpkg-buildpackage -uc -us
    changes=$(_ian-changes-path)

    printf "\nLINTIAN: %s\n" $changes
    lintian $changes
    )
}

# http://people.debian.org/~piotr/uscan-dl
function ian-svn-build {
    (
    _ian-preconditions
    ian-get-orig ../tarballs
    svn-buildpackage -rfakeroot -us -uc --svn-ignore --svn-ignore-new --svn-lintian
    )
}


#-- get orig ---------------------------------------------------------

# build the upstream orig file
# - with debian/rules get-orig-source target, or
# - from "local" files
function ian-get-orig {
    (
    _ian-preconditions
    destdir=$1
    if [ "$2" != "local" ] && grep -qs '^get-orig-source:' debian/rules; then
	ian-get-orig-source $destdir
    elif [ -f debian/watch ]; then
	ian-uscan $destdir
    else
	ian-build-orig-from-local $destdir
    fi
    ls $destdir/$(_ian-orig-filename)
    )
}

function ian-get-orig-source {
    echo '=> rules get-orig-source'
    ./debian/rules get-orig-source
    mv *.orig.tar.gz $1
}

function ian-uscan {
    echo '=> uscan', $1
    uscan --verbose --download-current-version --destdir $1
}

function ian-build-orig-from-local {
    destdir=$1
    echo '=> build-orig-from-local' $destdir

    app=$(_ian-source-name)
    EXCLUDE="--exclude=debian --exclude=\*~ --exclude=.hg --exclude=.svn --exclude=\*.pyc"

    orig_path=$destdir/$(_ian-orig-filename)
    rm $orig_path 2> /dev/null

    orig_dir=$app-$(_ian-upstream-version)
    mkdir -p $orig_dir

    tar $EXCLUDE --exclude=$orig_dir -cf - . | ( cd $orig_dir && tar xf - )
    tar -czf $orig_path $orig_dir
    \rm -rf $orig_dir
}

#-- clean ------------------------------------------------------------

function ian-clean {
    (
    _ian-preconditions
    dh clean
    if _ian-is-svn; then
	ian-svn-clean
    else
	ian-standard-clean
    fi
    )
}

function ian-standard-clean {
    (
    _ian-preconditions
    echo "=> standard-clean"
    for fname in $(_ian-generated-filenames); do
	\rm -fv ../$fname
    done
    for package in $(_ian-binary-names); do
	\rm -fv ../${package}_*.deb
    done
    )
}

function ian-svn-clean {
    echo "=> svn-clean"
    rm -vrf ../tarballs/* ../build-area/*
}


#-- install ----------------------------------------------------------

function ian-install {
    sudo dpkg -i $(_ian-binary-paths)
}

function ian-build-install {
    ian-build
    ian-install
}



#-- server actions ---------------------------------------------------

function ian-upload {
    changes=$(_ian-changes-path)
    debsign -k$GPGKEYID $changes
    dupload -f $changes
}

function ian-remove-package {
    ssh $REPOACCOUNT "reprepro -V -b $REPOPATH remove sid $1"
}

function ian-remove {
    for pkg in $(_ian-binary-names); do
	ian-remove-package $pkg
    done
}
