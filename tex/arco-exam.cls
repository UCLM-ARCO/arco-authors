% -*- mode:latex -*-
%
% author: David Villa Alises <David.Villa@gmail.com>
%
% LaTeX2ε for class and package writers:
%   http://www.latex-project.org/guides/clsguide.pdf
%
% Initial template taken from:
%   http://stackoverflow.com/questions/581916/how-do-you-extend-article-document-class-in-latex


\RequirePackage{arco-internal}

%% -- Variables de la clase ------------------------------------
\gdef\@arcoTopic{\arcoCommandHelp{arcoTopic}}
\def\arcoTopic#1{\gdef\@arcoTopic{#1}}
\gdef\@arcoExamDesc{\arcoCommandHelp{arcoExamDesc}}
\def\arcoExamDesc#1{\gdef\@arcoExamDesc{#1}}
\gdef\@arcoExamDate{\arcoCommandHelp{arcoExamDate}}
\def\arcoExamDate#1{\gdef\@arcoExamDate{#1}}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arco-exam}[2012/03/16 class for student exercises]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\PassOptionsToClass{pdftex,10pt,a4paper,spanish,color}{exam}
\ProcessOptions\relax
\LoadClass{exam}

\parskip=0.2cm
\reversemarginpar
\marginparwidth=3cm

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage{times}
\RequirePackage{multicol}

\RequirePackage[margin=1.8cm,top=3cm,bottom=2cm]{geometry}

\RequirePackage{graphicx}
\graphicspath{{/}{figures/}{./images/}}

\RequirePackage{enumitem}
\setlist{topsep=0pt}
\setlist{noitemsep}

\RequirePackage[%
  colorlinks=true,
  linkcolor=black,
  citecolor=blue,
  urlcolor=blue]{hyperref}

\RequirePackage[%
% colorgrid,
  texcoord]{eso-pic}

\RequirePackage{amssymb}
\RequirePackage{ifthen}
\RequirePackage{xargs}

\let\headrule\@undefined
\let\footrule\@undefined
\RequirePackage{titlesec}

\RequirePackage{atbeginend}
\AfterBegin{document}{
  \pointname{p}
  \addpoints
}

\BeforeEnd{document}{
  \label{arco:lastpage}
}

\RequirePackage{color}
\definecolor{gray25}{gray}{0.25}
\definecolor{uclm-light}{cmyk}{0,.05,.05,0}
\def\graycolor#1{\textcolor{gray25}{#1}}
\def\uclmcolor#1{\textcolor{uclm-light}{#1}}

% PANTONE 7427. R:60 G:8 B:15
\definecolor{uclmred}{rgb}{.60,.08,.15}

% Cool Gray 5. R:72 G:70 B:68
\definecolor{uclmgray}{rgb}{.72,.70,.68}

\newcommand{\ESIname}{\textbf{\textsf{Escuela Superior de Informática}}}

\newcommand{\ifcolor}[1]{#1}
\newcommand{\UCLMbglogo}{%
  \ifcolor{%
    \begin{picture}(0,0)
      \put(-55,-820){
        \uclmcolor{\includegraphics[width=1.1\textwidth]{%
            /usr/share/arco/figures/uclm-logo-bw-mp.pdf}}}
    \end{picture}}}


\newcommand{\UCLMhead}[2]{
  \setlength{\unitlength}{1in}
  \begin{picture}(0,0)
    \put(-0.5,0){\includegraphics[width=4cm]{%
        /usr/share/arco/figures/uclm.pdf}}
    \put(1.2,0.3){\makebox(0,0)[l]{\textsf{\textbf{\Large #1}}}}
    \put(1.2,0.055){\makebox(0,0)[l]{\textsf{\textbf{\large %
            \textcolor{uclmred}{\ESIname}}}}}
    \put(7.2,0.55){\makebox(0,0)[r]{%
        \parbox{0.7\textwidth}{
          \begin{flushright}
            #2
          \end{flushright}
      }}}
  \end{picture}
}

\newpagestyle{arcoStyle}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\@arcoExamDesc\\\@arcoExamDate}} %
          {\UCLMbglogo} %
          {}
  \setfoot{}{Pág. \thepage{}/\numpages}{}
}
\pagestyle{arcoStyle}

\newcommand{\arcoExamAdvice}[1]{
  \null
  \begin{center}
    \parbox{.92\textwidth}{\emph{\noindent
        #1
      }}
  \end{center}
  \bigskip
}

\newcommand{\arcoExamStudentForm}{
  \noindent
  Apellidos: \enspace\rule{0.44\textwidth}{.5pt} \enspace%
  Nombre:    \enspace\rule{0.23\textwidth}{.5pt} \enspace%
  Grupo:     \enspace\hrulefill
  \bigskip
}

\newcounter{choicecounter}

\newenvironment{arcoQuestion}[1]{
  \begin{minipage}{.95\textwidth}
    \question[#1]
}
{
  \end{minipage}
  \null \\[0.3cm]
  \setcounter{choicecounter}{0}
}

%\newcommand{\arcoStatement}[1]{%
%  #1\vspace{5pt}\par}

\newcommand{\arcoAnswer}[1]{%
\ifprintanswers #1 \else \phantom{88} \fi }

\newcommand{\arcoChoiceMark}{$\square$}
\newcommand{\arcoCorrectChoiceMark}{ %
\ifprintanswers $\blacksquare$ \hspace{-7.5pt} \else \arcoChoiceMark \fi }

\newcommand{\arcoEmptyChoice}[2]{
  \stepcounter{choicecounter}
  {\fontsize{15pt}{15pt}\selectfont #1 }\hspace{2pt}
  \textbf{\alph{choicecounter}})\hspace{4pt}\parbox[t]{.9\textwidth}{#2\\[-.3cm]}%
  % dont remove this

}

\newcommand{\choice}[1]{\arcoEmptyChoice{\arcoChoiceMark}{#1}}
\newcommand{\correctChoice}[1]{\arcoEmptyChoice{\arcoCorrectChoiceMark}{#1}}

\newlength{\altolinea}
\addtolength{\altolinea}{0.5cm}

\newcommand{\arcoSolutionorbox}[2]{
  \fbox{
    \parbox{.97\textwidth}{
      \ifprintanswers
      #2
      \else
      \rule{0mm}{#1\altolinea}
      \rule{.9\textwidth}{0mm}
      \fi
    }}
}

\RequirePackage{arco-listings}

\endinput
