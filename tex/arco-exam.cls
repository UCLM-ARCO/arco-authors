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

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arco-exam}[2012/03/16 class for student exercises]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\PassOptionsToClass{pdftex,10pt,a4paper,spanish,color}{exam}
\ProcessOptions\relax
\LoadClass{exam}

\RequirePackage{times}
\RequirePackage{multicol}

\RequirePackage[margin=1.8cm,top=3cm,bottom=2cm]{geometry}

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
}

\BeforeEnd{document}{
  \label{arco:lastpage}
}

\RequirePackage{arco-color}


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
  \setlength{\unitlength}{1cm}
  \begin{picture}(0,0)
    \put(-1.3,0){\includegraphics[width=4cm]{%
        /usr/share/arco/figures/uclm.pdf}}
    \put(3,1.6){\makebox(0,0)[l]{\textsf{\textbf{\Large #1}}}}
    \put(3,1.1){\makebox(0,0)[l]{#2}}
    \put(3,0.14){\makebox(0,0)[l]{\textsf{\textbf{\large %
            \textcolor{uclmred}{\ESIname}}}}}
  \end{picture}
}

\newcommand{\qualificationBox}{
  \setlength{\unitlength}{1cm}
  \begin{picture}(0,0)
    \put(10,1.2){
      \makebox(0,0)[r]{%
        \parbox{0.7\textwidth}{
          \fcolorbox{gray50}{white}{%
            \textcolor{gray50}{\hspace{.5cm}calificación}
            \rule{0cm}{2cm}
            \rule{0.3cm}{0cm}
          }}}}
  \end{picture}
}

\newpagestyle{firstpage}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\@arcoExamDesc}} %
          {\UCLMbglogo} %
          {\qualificationBox}
  \setfoot{\@arcoExamDate}{}{\thepage{}/\numpages}
}

\newpagestyle{main}[\small\sffamily]{
  \sethead{\UCLMhead{\@arcoTopic}{\@arcoExamDesc}} %
          {\UCLMbglogo} %
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
  \bigskip
}

\usepackage{calc}

% \newlength{\remaining}
% \newcommand{\titleline}[1]{%
%   \setlength{\remaining}{(\textwidth-\widthof{\textsc{#1}})/2}
%   \noindent\underline{\hspace*{\remaining}#1\hspace*{\remaining}}\par}

\newlength{\remaining}
\newcommand{\undertitleline}[1]{%
% \setlength{\remaining}{(\textwidth-\widthof{\textsc{#1}})/2}
  \setlength{\remaining}{0.15\textwidth}
  \noindent\underline{\hspace*{\remaining}#1\hspace*{\remaining}}}


\newcommand{\arcoExamStudentForm}{
  \noindent
  Apellidos:
  \ifprintanswers
  \undertitleline{\Large SOLUCIÓN}
%  \enspace\rule{0.15\textwidth}{.5pt}{\Large SOLUCIÓN}\rule{0.15\textwidth}{.5pt}
  \else
%  \enspace\rule{0.44\textwidth}{.5pt} \enspace
  \underline{\hspace*{0.44\textwidth}}
  \fi
  \enspace Nombre:    \underline{\hspace*{0.23\textwidth}}%
  \enspace Grupo:     \underline{\hspace*{1cm}}
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

\newcommand{\arcoAnswer}[1]{%
\ifprintanswers #1 \else \phantom{88} \fi }

\newcommand{\arcoChoiceMark}{$\square$}
\newcommand{\arcoCorrectChoiceMark}{ %
\ifprintanswers $\blacksquare$ \hspace{-7.5pt} \else \arcoChoiceMark \fi }

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

\newcommand{\arcoSolutionorbox}[2]{
  \fcolorbox{gray90}{white}{
    \parbox{.97\textwidth}{
      \ifprintanswers
      #2
      \else
      \rule{0mm}{#1\altolinea}
      \rule{.9\textwidth}{0mm}
      \fi
    }}
}

\newcommand{\arcoFigureWithAnswer}[3]{
  \ifprintanswers
  \includegraphics[width=#1\textwidth]{#3}
  \else
  \includegraphics[width=#1\textwidth]{#2}
  \fi
}

\RequirePackage{arco-listings}

\endinput
