\ProvidesClass{mcresume}[2024/01/21 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

% page layout packages
\usepackage{blindtext}
\usepackage[utf8]{inputenc}
\usepackage{enumitem}
\usepackage{xcolor}
\usepackage{geometry}
\usepackage{titlesec}
\usepackage[most]{tcolorbox}
\geometry{margin=0pt}

%%
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage{fontawesome}
\RequirePackage{etoolbox}
\usepackage{hyperref}

\usepackage{graphicx}
\graphicspath{ {./} }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
%%%%%%%%%% end packages

\pagestyle{empty}

\hypersetup{colorlinks=true,linkcolor=blue,urlcolor=blue}

\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{f2f2f2}
\definecolor{mainblue}{HTML}{000F61}
\definecolor{maingray}{HTML}{f2f2f2}
\definecolor{bluecolorurl}{HTML}{142376}

\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead

% ------------------ page layout ------------------------- %

% https://tex.stackexchange.com/a/310989/109031
% https://tex.stackexchange.com/questions/220094/vertical-spacing-vfill-inside-tcolorbox
% options, from tcolorbox package docs: https://ctan.mirror.garr.it/mirrors/ctan/macros/latex/contrib/tcolorbox/tcolorbox.pdf
% - nobeforeafter: Abbreviation for clearing the keys before and after. The colored box is not put into a paragraph and there is no space before or after the box.
% - boxrule=0pt: boxrule=⟨length⟩ (style, no default, initially 0.5mm) Sets all rules of the frame to ⟨length⟩
% - enhanced jigsaw: abbreviation for skin=enhanced, while this skin translates the drawing commands of the core package into tikz path commands
% - height=⟨length⟩ Sets the total height of the colored box to ⟨length⟩ independent of the box content. (no default)
% - text fill This style sets /tcb/before upper→ P. 70 and /tcb/after upper→ P. 71 to embed the upper part with a minipage. This allows to use vertical glue macros like \vfill to act like expected. If the box has no fixed height, setting /tcb/text fill has no other effect as making the box unbreakable. (style, no value)
\newtcolorbox{sidebgbox}[1][]{nobeforeafter,boxrule=0pt,enhanced jigsaw,height=\heigthpage,text fill,#1}
\newtcolorbox{bgbox}[1][]{nobeforeafter,boxrule=0pt,enhanced jigsaw,#1}

\newcommand{\sidesection}[1]{%
    \noindent
    \begin{sidebgbox}[height=\paperheight,colback=sidecolor,width=0.30\textwidth]
    #1
    \end{sidebgbox}%
}
\newcommand{\mainsection}[1]{%
    \noindent
    \begin{bgbox}[height=\paperheight,colback=white,width=0.67\textwidth]

    #1
    \end{bgbox}%
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\vspace{4pt}% Whitespace before the section title
	\settowidth{\SectionTitleLength}{\large #1 }% Calculate the width of the section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
	\addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{mainblue} \large #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% show different url and colorize
\newcommand{\colorhrefcustom}[2]{\href{#1}{\textcolor{bluecolorurl}{{#2}}}}
\newcommand{\colorhref}[1]{
    \colorhrefcustom{https://#1}{#1}
}

% Define custom commands for CV info
\newcommand{\cvbirthdate}[1]{\renewcommand{\cvbirthdate}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvaddressurl}[1]{\renewcommand{\cvaddressurl}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvsitepersonal}[1]{\renewcommand{\cvsitepersonal}{#1}}
\newcommand{\cvstackoverflow}[1]{\renewcommand{\cvstackoverflow}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvskypeurlbase}[1]{\renewcommand{\cvskypeurlbase}{#1}}
\newcommand{\cvskypeurl}[1]{\renewcommand{\cvskypeurl}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[2]{\tikz[baseline=(char.base)]{\node[shape=circle, draw, inner sep=1pt, fill=mainblue, mainblue, text=white, minimum size=16pt, font=\fontsize{#2}{12}\selectfont] (char) {#1};}}

%----------------------------------------------------------------------------------------
%	 SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

\newcommand{\makenamejobrows}{

    %------------------------------------------------

    {\Large\color{mainblue}\cvname\medskip}

    {\large\color{black!80}\cvjobtitle\bigskip}

}

\newcommand{\makeheaderprofilenoimg}{
    \bigskip
    \makenamejobrows
}

\newcommand{\makeheaderprofile}{

	% use \centerline to handle image margins
    \centerline{\includegraphics[width=\textwidth]{\profilepic}\bigskip}

    %------------------------------------------------

    \makenamejobrows

}

\newcommand{\makeinfoprofile}{
    \begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
        \ifthenelse{\equal{\cvbirthdate}{}}{}{\textsc{\Large\icon{\faCalendar}{10pt}} & \cvbirthdate\\}

        \ifthenelse{
                \equal{\cvaddress}{}
        }{}{
                \ifthenelse{
                        \equal{\cvaddressurl}{}
                }{
                        \textsc{\Large\icon{\faMapMarker}{12pt}} & \cvaddress
                }{
                        \textsc{\Large\icon{\faMapMarker}{12pt}} & \colorhrefcustom{https://\cvaddressurl}{\cvaddress}
                }
        \\}

        \ifthenelse{\equal{\cvnumberphone}{}}{}{\textsc{\Large\icon{\faPhone}{12pt}} & \cvnumberphone\\}

        \ifthenelse{\equal{\cvsitepersonal}{}}{}{\textsc{\Large\icon{\faGlobe}{11pt}} & \colorhref{\cvsitepersonal}\\}

        \ifthenelse{\equal{\cvgithub}{}}{}{\textsc{\Large\icon{\faGithub}{11pt}} & \colorhrefcustom{https://github.com/\cvgithub}{\cvgithub}\\}

        \ifthenelse{\equal{\cvmail}{}}{}{\textsc{\Large\icon{\faAt}{11pt}} & \colorhrefcustom{mailto:\cvmail}{\cvmail}\\}

        \ifthenelse{\equal{\cvlinkedin}{}}{}{\textsc{\Large\icon{\faLinkedin}{11pt}} & \colorhrefcustom{https://www.linkedin.com/in/\cvlinkedin/en}{\cvlinkedin}\\}

        \ifthenelse{\equal{\cvskypeurl}{}}{}{\textsc{\Large\icon{\faSkype}{11pt}} & \colorhrefcustom{https://\cvskypeurlbase}{\cvskypeurl}\\}

        \ifthenelse{\equal{\cvstackoverflow}{}}{}{\textsc{\Large\icon{\faStackOverflow}{10pt}} & \colorhrefcustom{https://stackoverflow.com/users/\cvstackoverflow}{\cvstackoverflow}\\}
    \end{tabular}

}


\newcommand{\aboutme}[1]{
    \begin{flushleft}
        \textsc{#1}
    \end{flushleft}
}

\newcommand{\customsidesection}[2]{
    \profilesection{#1}
    \begin{flushleft}
        #2
    \end{flushleft}
}

\newcommand{\customskills}[3]{%
    \profilesection{#1}
    \smallskip
    \smallskip
    \begin{itemize}[labelindent=1em,labelsep=0.3em,leftmargin=0.8em]

       \foreach \i in {#2} {
           \item \i
       }
    \end{itemize}

    % Show this description label only if optional third argument is not empty
    \ifthenelse{\equal{#3}{}}{}{\scriptsize #3 \normalsize}
    \smallskip
}

\newcommand{\makefooterprofile}[2]{
        \smallskip
        \scriptsize
		#1.\newline
		#2
}


%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE BOX
%----------------------------------------------------------------------------------------

\newcommand{\customsection}[1]{%
  \colorbox{maingray}{\parbox{\dimexpr\textwidth-2\fboxsep}{\large #1}}
}

\renewcommand{\section}[1]{
	{%
            \bigskip
		\color{mainblue}%
		\customsection{#1}%
            % \smallskip
	}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{%
		\large\color{maingray} #1%
	}
	\par\vspace{.25\parskip}%
}

%----------------------------------------------------------------------------------------
%	 LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{twenty}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\workplace}[1]{%
    \ifx#1\remote
        \textcolor{gray}{Remote}
    \else\ifx#1\hybrid
        \textcolor{darkgray}{Hybrid}
    \else\ifx#1\onsite
        \textcolor{darkgray}{On-site}
    \else
        \textcolor{gray}{Unknown}
    \fi\fi\fi
}

\newcommand{\remote}{remote}
\newcommand{\hybrid}{hybrid}
\newcommand{\onsite}{on-site}


\newcommand{\workitem}[7]{%
	\small\scalebox{.7}[1.0]{#1--#2}&\parbox[t]{0.82\textwidth}{
		\scalebox{.9}[1.1]{#3}
		\hfill
        \smallskip
		{\footnotesize#4}\hspace{2pt}$\vert$\hspace{2pt}{\footnotesize\textit{\workplace{#5}}}\\
		\textbf{#6}\\
        Skills: \small\textit{#7}\vspace{\parsep}
	}\\
    \smallskip
}
