\version "2.18.2"
\header {
  title = "打上花火 （うちあげはなび）"
  subtitle = "GuZheng"
  composer = "Composer: DAOKO×米津玄師"
}
% 古箏定弦
\new ChoirStaff <<
  \new Staff {
    \key f \major
    \tempo "古箏定弦"  
    \omit Score.BarLine
    \repeat unfold 8 { s4 }
    c'4 d' e' f'
    g' a' c'' d''
    f'' g'' a'' c'''
    d'''
    }

  \new Staff {
    \clef bass
    \key f \major
    \omit Score.BarLine
    d,4 f, g, a,
    c d f a
    \repeat unfold 13 { s4 }
    }
  >>

\layout {
  \context {
    \Score
    % \override StaffGrouper.staff-staff-spacing.padding = #0
    % \override StaffGrouper.staff-staff-spacing.basic-distance = #1
  }
}
% ----------------------------------------
<<
  \new PianoStaff \with {instrumentName = #"GuZheng"}
  <<
    \new Staff {
      %setting
        \key f \major
        \time 4/4

        % 1-4
            g''8 a'' c''' f'' g'' a'' c''' f''  | %1
            g''8 a'' c''' d''' g'' a'' d'' f''  | %2
            g''8 a'' c''' f'' g'' a'' c''' f''  | %3
            g''8 a'' c''' d''' g'' a'' d'' f''  | %4
        % 5-8
            g'8 a' c'' f' g' a' c'' f'  | %5
            g'8 a' c'' f' g' a' c'' f'  | %6
            g'8 a' c'' f' g' a' c'' f'  | %7
            g'8 a' c'' f' g' a' r4     | %8
        % 9-12
            r4 f'8 g'4 f'8 c''8 r8 | %9
            r4 <e' f'>4 r4 f'8 e' | %10
            d'4 f' e'8 c'4 <a c'>8 | %11
            c'4 r2 r4 | %12
        % 13-16
            r4 f'8 g'4 f'8 r4 | %13
            r4 e'8 f' r4 f'8e' | %14 
            d'4 f' e'8 c' c' c' | %15
            d'4 r2 d'8 e' | %16
        % 17-20
            f'4. e'8 d' e' f'4 | %17
            r8 e' d' e' f' e' c' d' | %18
            c'8 f f d' c' f g g | %19
            a4 <e' f' g' a'>4 r4 d'8e' | %20 
        % 21-24
            f'4. e'8 d' e' f'4 | %21
            r8 e' d' e' f' g' a' bes' | %22
            bes'8 f' f'8 g'16 a' g'8 f' f'4 | %23
            r2 r4 a'8 c''16 a' | %24 
        % 25-28
            g'8 f' d'16 f'8 g'8 a'16 r8 a'8 c''16 a' | %25 
            g'8 f' c'16 f' 8 f'16 f'8 r8 a'8 c''16 a' | %26 
            g'8 r8 a'16 c''8 c''8 d''8. c''16 bes' a'8 | %27
            a'2 r4 a'8 c''16 a' | %28 
        % 29-32
            g'8 f' d'16 f' 8 g'16 g'8 r8 a'8 c''16 a' | %29

        % 33-36
    }

    \new Staff {
        \new Voice = "melody" {
      % setting
        \clef bass
        \key f \major

        %1-4
            c2 a,   | %1
            g, f,   | %2
            <c a,>2 <a, g,>2    | %3
            <g, f,>2 <f, d,>2   | %4
        %5-8
            f,8 g, a, c f,8 g, a, c | %5
            <c f,>2 <a, g,> | %6
            f,2 f, | %7
            r2 r4 a,8 c | %8
        % 9-12
            d4 r2 r8 bes| %9
            a8 c' f,4 r2 | %10
            d,8 a, c d r4 r8 c8 | %11
            r2 r4 a8 c' | %12
        % 13-16
            <d d'>4 r2 c'8 bes | %13
            a8 c' r8 f,8 r2 | %14 
            d,8 a, <c d>4 r2 | %15
            r1 | %16
        % 17-20
            <d, d>2 <f, f>2 | %17
            r4 d f a | %18
            c' r2 r4 | %19
            a,4 r4 r2| %20
        % 21-24
            <d, a, f>2 <f, a, f>2 | %21
        % 25-28
        % 29-32
        % 33-36
        }
    }
    \new Lyrics {
        \lyricsto "melody" {
            \repeat unfold 20 { \skip 1 }
            あ8 の | %8
            ひ み わ た し た | %9
        }
    }
  >>
>>