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
\gdef\@arcoTopic{\texcmd{arcoTopic}}
\def\arcoTopic#1{\gdef\@arcoTopic{#1}}
\gdef\@arcoExamDesc{\texcmd{arcoExamDesc}}
\def\arcoExamDesc#1{\gdef\@arcoExamDesc{#1}}
\gdef\@arcoExamDate{\texcmd{arcoExamDate}}
\def\arcoExamDate#1{\gdef\@arcoExamDate{#1}}
\gdef\@arcoExamCourse{\texcmd{arcoExamCourse}}
\def\arcoExamCourse#1{\gdef\@arcoExamCourse{#1}}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arco-exam}[2012/03/16 class for student exercises]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\PassOptionsToClass{pdftex,10pt,a4paper,color}{exam}
\ProcessOptions\relax
\LoadClass{exam}

\RequirePackage{times}
\RequirePackage{multicol}
\setlength{\multicolsep}{4.0pt plus 1.5pt minus 1.0pt}% 50% of original values

\RequirePackage{tikz}
\RequirePackage{marginnote}
\RequirePackage{textpos}
% \usepackage{calc}

\RequirePackage[a4paper, inner=1.4cm,outer=1cm,top=3cm,bottom=1cm,footskip=0.7cm]{geometry}

\RequirePackage{arco-basics}

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
  \bracketedpoints
  \newcounter{plainQuestionCounter}
}

\RequirePackage{enumitem}
\setlist{topsep=2pt, itemsep=-2pt}

\RequirePackage{transparent}
\RequirePackage{xifthen}
\RequirePackage[yyyymmdd,hhmmss]{datetime}
\RequirePackage{arco-color}

\newcommand{\ESIname}{\textbf{\textsf{Escuela Superior de Informática}}}

\newcommand{\UclmWatermark}{%
  \begin{picture}(0,0)
    \put(-55,-820){
      \uclmcolor{\includegraphics[width=1.1\textwidth]{%
          /usr/share/arco/figures/uclm_logo_watermark.pdf}}}
  \end{picture}}


\newcommand{\UCLMhead}[2]{
  \setlength{\unitlength}{1cm}
  \begin{picture}(0,0)
    \put(-1.3,0){\includegraphics[width=4cm]{%
        /usr/share/arco/figures/uclm_logomarca_1.pdf}}
    \put(3,1.6){\makebox(0,0)[l]{\textsf{\textbf{\Large #1}}}}
    \put(3,1.1){\makebox(0,0)[l]{#2}}
    \put(3,0.14){\makebox(0,0)[l]{\textsf{\textbf{\large
            \textcolor{uclmred}{\ESIname}}}}}
  \end{picture}
}

% localization
\newcommand{\localeScore}{
  \iflanguage{english}{score}{calificación}
}

\newcommand{\localeSurname}{
  \iflanguage{english}{Surname:}{Apellidos:}
}

\newcommand{\localeFirstname}{
  \iflanguage{english}{Firstname:}{Nombre:}
}

\newcommand{\localeGroup}{
  \iflanguage{english}{Group:}{Grupo:}
}


\newcommand{\qualificationBox}{
  \setlength{\unitlength}{1cm}
  \begin{picture}(0,0)
    \put(10.2,1.0){
      \makebox(0,0)[r]{%
        \parbox{0.7\textwidth}{
          \fcolorbox{gray50}{white}{%
            \textcolor{gray50}{\hspace{1.66cm}}
            \rule{0cm}{1.76cm}
            \rule{0.5cm}{0cm}
          }}}
    }
  \end{picture}
}

\newcommand{\examCourse} {
  \iflanguage{english}{Course}{Curso} \@arcoExamCourse\ ::\
}

\newpagestyle{firstpage}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\examCourse \@arcoExamDesc}} %
          {\UclmWatermark} %
          {\qualificationBox
            \begin{picture}(0,0)
              \put(-1.94,1.87){\scalebox{.4}{\today~\currenttime}}
            \end{picture}}
  \setfoot{\@arcoExamDate}{}{\thepage{}/\numpages}
}

\newpagestyle{main}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\examCourse \@arcoExamDesc}} %
          {\UclmWatermark} %
          {}
  \setfoot{\@arcoExamDate}{}{\thepage{}/\numpages}
}

\pagestyle{main}
\thispagestyle{firstpage}

\newcommand{\arcoExamAdvice}[1]{
  \null
  \begin{center}
    \parbox{.92\textwidth}{\emph{\noindent
        #1
      }}
  \end{center}
  \medskip
}

\renewcommand{\arcoExamAdvice}[1]{
  \fbox{
  \parbox{\textwidth}{
    {\itshape #1}
  }}
  \medskip
}

\usepackage{calc}

\newlength{\remaining}
\newcommand{\undertitleline}[1]{%
% \setlength{\remaining}{(\textwidth-\widthof{\textsc{#1}})/2}
  \setlength{\remaining}{0.15\textwidth}
  \noindent\underline{\hspace*{\remaining}#1\hspace*{\remaining}}}

% question counters

\newcommand{\boxed}[1] {
    \fboxsep=2pt%
    \fcolorbox{black}{black}{%
      \textcolor{white}{\sffamily\bfseries #1}%
    }
}

\newcommand{\showQuestionLabel}{}
\newcommand{\hideQuestionLabel}{}

\newcommand{\usePlainQuestionCounter}{
  \renewcommand{\showQuestionLabel} {
    \renewcommand{\questionlabel} {
      \boxed{\theplainQuestionCounter}
    }
  }

  \renewcommand{\hideQuestionLabel} {
    \renewcommand{\questionlabel} {E.}
  }

  \renewcommand{\partlabel}{>\boxed{\theplainQuestionCounter}}
}


\newcommand{\answerFormat}[1]{{\small\color{blue} #1}}


\newcommand{\arcoExamStudentForm}{
  \noindent
  \localeSurname
  \ifprintanswers
  \undertitleline{\large SOLUCIÓN}
%  \enspace\rule{0.15\textwidth}{.5pt}{\Large SOLUCIÓN}\rule{0.15\textwidth}{.5pt}
  \else
%  \enspace\rule{0.44\textwidth}{.5pt} \enspace
  \underline{\hspace*{0.44\textwidth}}
  \fi
  \enspace \localeFirstname    \underline{\hspace*{0.23\textwidth}}%
  \enspace \localeGroup        \underline{\hspace*{1cm}}
  \mbox{}
  \medskip
}

\newcounter{choicecounter}

\newenvironment{simpleQuestion}[1][]{
  \setcounter{choicecounter}{0}
  \stepcounter{plainQuestionCounter}
  \showQuestionLabel
  \begin{minipage}{\textwidth}
  \ifthenelse{\isempty{#1}}%
    {\question}
    {\question[#1]}
}
{
  \end{minipage}
  \null \\[0.3cm]
}

\newenvironment{multiQuestion}[1][]{
  \setcounter{choicecounter}{0}
  \hideQuestionLabel
  \begin{minipage}{.98\textwidth}
  \ifthenelse{\isempty{#1}}%
    {\question}
    {\question[#1]}
}
{
  \end{minipage}
  \null \\[0.3cm]
}

\newcommand{\subQuestion}[1][]{
  \setcounter{choicecounter}{0}
  \stepcounter{plainQuestionCounter}
  \ifthenelse{\isempty{#1}}%
    {\part}
    {\part[#1]}
  }


\newcommand{\arcoAnswer}[1]{%
\ifprintanswers \answerFormat{#1} \else \phantom{88} \fi }

\newcommand{\arcoChoiceMark}{$\square$}
\newcommand{\arcoCorrectChoiceMark}{%
\ifprintanswers $\blacksquare$ \hspace{-7.5pt} \else \arcoChoiceMark \fi}

\newcommand{\onlyInStatement}[1]{%
\ifprintanswers \null \else #1 \fi}

\newcommand{\arcoEmptyChoice}[2]{
  \stepcounter{choicecounter}
  {\fontsize{15pt}{15pt}\selectfont #1 }\hspace{2pt}
  \textbf{\alph{choicecounter}})\hspace{4pt}\parbox[t]{.9\textwidth}{#2\\[-.3cm]}%
  % DO NOT REMOVE THESE LINES

}

\newcommand{\choice}[1]{\arcoEmptyChoice{\arcoChoiceMark}{#1}}
\newcommand{\correctChoice}[1]{\arcoEmptyChoice{\arcoCorrectChoiceMark}{#1}}

\newlength{\altolinea}
\addtolength{\altolinea}{5mm minus 2mm}


\newcommand{\printsolution}[1]{%
  \vspace{0.5mm plus 0.5mm}
  \fcolorbox{gray90}{white}{
    \parbox{.97\textwidth}{
      \answerFormat{#1}
    }}
  \vspace{0.5mm plus 1.5mm minus 1.5mm}
}

\newcommand{\arcoSolutionorbox}[2]{
%  lines:#1- \\
  \ifprintanswers
  \printsolution{#2}
  \else
  \ifthenelse{\not\isempty{#1}}{%
    \printsolution{
      \rule{0mm}{#1\altolinea}
      \rule{.9\textwidth}{0mm}
    }
  }
  \fi
}

\newcommand{\arcoFigureWithAnswer}[3]{
\begin{center}
   \ifprintanswers
  \includegraphics[width=#1\textwidth]{#3}
  \else
  \includegraphics[width=#1\textwidth]{#2}
  \fi
\end{center}
}

\RequirePackage{arco-listings}

\endinput
