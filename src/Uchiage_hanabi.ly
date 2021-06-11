\version "2.18.2"

\header {
    title = "打上花火 （うちあげはなび）"
    subtitle = "GuZheng"
    composer = "Composer: DAOKO×米津玄師"
    arranger = "Arranger: 莊曉涵×謝岱霖"
    tagline = ##f 
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

% Music score --------------------
% right hand
RHMusic = {
    \key f \major
    \time 4/4
    \tempo 4 = 96

    % 1-4
        g''8 \mf a'' c''' f'' g'' a'' c''' f''  | %1
        g''8 a'' c''' d''' g'' a'' d'' f''  | %2
        g''8 \accent a'' c''' f'' g'' a'' c''' f''  | %3
        g''8 a'' c''' d''' g'' a'' d'' f''  | %4
    % 5-8
        g'8 \accent a' c'' f' g' a' c'' f'  | %5
        g'8 a' c'' f' g' a' c'' f'  | %6
        g'8\> a' c'' f'\! g'\< a' c'' f'\!  | %7
        g'8 a' c'' f' g'\open a'\open  \fermata r4     | %8
    % 9-12
        r4 f'8 g'8~ g'8 f'8 c'8 bes8 | %9
        r4 e'4( \grace{f'16) } r4 f'8 e' | %10 
        d'4 f' e'8 c'4 a8(\( \grace{c')} | %11
        c'4\) r2 r4 | %12
    % 13-16
        r4 f'8 g'4 f'8 r4 | %13
        r4 e'8 f' r4 f'8e' | %14 
        d'4 f' e'8 c' c' c' | %15
        d'4 r2 d'8 e' | %16
    % 17-20
        f'4. e'8 d' e' f'4 | %17
        r8 e' d' e' f' e' c' d' | %18
        c'8 r4.  c'8 r4.| %19
        r4 
        \arpeggioNormal<e' f' g' a'>4\arpeggio
        r4 d'8 e' | %20 
    % 21-24
        f'4. e'8 d' e' f'4 | %21
        r8 e' d' e' f' g' a' 
        \override NoteHead.color = #red 
        bes' | %22
        bes'8 
        \override NoteHead.color = #black 
        f' f'8 g'16 a' g'8 f' f'4 | %23
        r2 r4 a'8 c''16 a' | %24 
    % 25-28
        g'8 f' d'16 f'8 g'8 a'16 r8 a'8 c''16 a' | %25 
        g'8 f' c'16 f' 8 f'16 f'8 r8 a'8 c''16 a' | %26 
        g'8 r8 a'16 c''8 c''8 d''8. c''16 
        \override NoteHead.color = #red 
        bes' 
        \override NoteHead.color = #black
        a'8 | %27
        a'2 r4 a'8 c''16 a' | %28 
    % 29-32
        g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | %29
        g'8 f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | %30 
        d'8. d'16 g'4 e'8 d' e' e' | %31
        e'8 f'4. f'4 r4 | % 32
    % 33-36
        g'8 a' c'' f' g'8 a' c'' f'  | %33
        g'8 a' c'' f' g'8 a' c'' f'  | %34
        g'8 a' c'' f' g'8 a' c'' f'  | %35
        g'8 a' c'' f' g'8 a' r8 f'16 g'  | %36
    % 37-40 
        a'8 g'16 f' f'8 d'16 e' f'8 e'16 d' c'8 a16 c' | %37
        d'8 e'16 f' e' c' c' d' c'4 a16 a c' c' | %38 
        d'8 e'16 f' e'8 f'16 g' a'8 g'16 f' e'8 c'16 c'| %39 
        c'4 r2 r8 f'16 g' | %40 
    % 41-44
        a'8 g'16 f' f'8 d'16 e' f'8 e'16 d' c'8 c'16 c' | %41
        d'16 d' e' f' e' c' c' d' c' c' r8 d8. c'16 | %42
        c'8 d' d'16 f'8. g'8. a'16 a'8 g' | %43
        f'8 f'4. r2 | %44
    % 45-48
        d''4 c''8 
        \override NoteHead.color = #red
        bes' 
        \override NoteHead.color = #black
        a'4 g'16 a' 
        \override NoteHead.color = #red
        bes'8| %45
        bes'16 
        \override NoteHead.color = #black
        a' g' f' f' g' a' 
        \override NoteHead.color = #red
        bes' bes' 
        \override NoteHead.color = #black
        a' g' f' f' d' e' f' | %46
        f'16 e' d' c' c'8 c' d'8. f'16 f'8 e' | %47 
        e'16 c'8 a16 a8. d'16 d'2 | %48 
    % 49-52
        d''4 c''8 
        \override NoteHead.color = #red
        bes' 
        \override NoteHead.color = #black
        a'4 g'16 a' 
        \override NoteHead.color = #red
        bes'8 | %49
        bes'4 
        \override NoteHead.color = #black
        a'16 g' a'8 a'4 r4 | %50 
        r4. 
        \override NoteHead.color = #red
        bes'8 
        \override NoteHead.color = #black
        a' g' f' f' | %51 
        r1 | %52
    % 53-56
        r1 | %53
        r1 | %54 
        r2 r4 a'8 c''16 a' | %55
        g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a'16 | %56
    % 57-60
        g'8 f' d'16 f'8 f'16 f'8 r8 a'8 c''16 a'16 | %57
        g'8 r8 a'16 c''8 c''16 c'' d''8. c''16 
        \override NoteHead.color = #red
        bes' 
        \override NoteHead.color = #black
        a'8| %58
        a'2 r4 a'16 a' c'' a' | %59
        g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | %60
    % 61-64
        g'8 f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | %61 
        d'4 g' e'8 c' a e' | %62
        e'8 f'4. r2 | %63
        r8 c'' a'16 g' f' g' g'2 | %64
    % 65-68
        r8 c'' a'16 g' f' g' g'2 | %65
        r8 c'' a'16 g' f' g' g'2 | %66
        r8 d'' c''16 
        \override NoteHead.color = #red
        bes' bes' 
        \override NoteHead.color = #black
        c'' c''2 | %67
        r8 c'' a'16 g' f' g' g'2 | %68
    % 69-72
        r8 c'' a'16 g' f' g' g'2 | %69
        r8 c'' a'16 g' f' g' g'8 f'16 g' a'8 
        \override NoteHead.color = #red
        bes' 
        \override NoteHead.color = #black
        | %70
        g'8 g'4. r2 | %71 
        g''8 a'' c''' f'' g''8 a'' c''' f'' | %72
    % 73-76
        g''8 a'' c''' f'' g''8 a'' c''' f''| %73
        g''8 a'' c''' f'' g''8 a'' c''' f''| %74
        g''8 a'' c''' f'' g''8 a'' r4| %75
        r4 f'8 g' g' f' c' 
        \override NoteHead.color = #red
        bes 
        \override NoteHead.color = #black
        | %76
    % 77-80
        a8 c' f'4 r4 f'8 e' | %77
        d'4 f' e'8 c'4 c'8  | %78
        c'4 r2 a8 c' | %79
        d'4 f'8 g' g' f' c' 
        \override NoteHead.color = #red
        bes 
        \override NoteHead.color = #black
        | %80
    % 81-84
        a8 c' e' f' r4 f'8 e' | %81
        d'4 f' e'8 c' c' d' | %82
        d'4 r2 a'8 c''16 a' | %83
        g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | %84
    % 85-88
        g'8 f' c'16 f'8 f'16 f'8 r8 a'8 c''16 a' | %85
        g'8 r8 a'16 c''8 c''16 c''16 d''8. c''16 
        \override NoteHead.color = #red 
        bes' 
        \override NoteHead.color = #black
        a'8 | %86
        a'2 r4 a'8 c''16 a' | %87
        g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | %88
    % 89-92
        g'8 f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | %89
        d'8. d'16 g'4 e'8 d' e' e' | %90
        e'8 f'4. r2 | %91 
        d'4 d'16 e' f'8 g'4 a'8 f' | %92
    % 93-96
        f'4 a'16 g' f'8 g'4 c''8 a' | %93
        a'4 f'8 c' d'4 c'8 
        \override NoteHead.color = #red 
        bes 
        \override NoteHead.color = #black
        |  %94
        c'2 r2 | %95
        d'4 d'16 e' f'8 g'4 a'8 f' | %96
    % 97-100
        f'4 a'16 g' f'8 g'4 c''8 a' | %97
        d'4. a'8 g'4. f'16 g' | %98
        a'4. g'16 f' f'2 | %99
        d'4 d'16 e' f'8 g'4 a'8 f' | %100
    % 101-104
        f'4 a'16 g' f'8 g'4 c''8 a' | %101
        a'4 f'8 c' d'4 c'8 
        \override NoteHead.color = #red 
        bes' 
        \override NoteHead.color = #black
        | %102
        c'2 r2 | %103
        d'4 d'16 e' f'8 g'4 a'8 f' | %104
    % 105-108
        f'4 a'16 g' f'8 g'4 c''8 a' | %105
        d''4. a'8 g'4. f'16 g' | %106
        a'4. g'16 f' f'2 | %107
        g''8 a'' c''' f'' g''8 a'' c''' f'' | %108
    % 109-112
        g''8 a'' c''' f'' g''8 a'' c''' a'' | %109
        g''8 a'' c''' f'' g''8 a'' c''' f'' | %110
        g''8 a'' c''' f'' g''8 a'' c''' f'' | %111
        g''8 a'' f'' g'' r2 | %112
}
% left hand
LHMusic = {
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
        r2. a,8\open c\open | %8
    % 9-12
        \override NoteHead.color = #red
        d4\open 
        \override NoteHead.color = #black
        r2.| %9
        a8 c' f,4 r2 | %10
        d,8 a, c d r4. <a, c>8 | %11
        r2. a8 c' | %12
    % 13-16
        \override NoteHead.color = #red
        <d d'>4 
        \override NoteHead.color = #black
        r2 c'8 bes | %13
        a8 c' r8 f,8 r2 | %14 
        d,8 a, <c d>4 r2 | %15
        r1 | %16
    % 17-20
        <d, d>2 <f, f>2 | %17
        r4 d, f, a, | %18
        c8 f f d c8 f  
        \override NoteHead.color = #red
        g8 g 
        \override NoteHead.color = #black  | %19
        <a, a >4 r2. | %20
    % 21-24
        <d, a, f>2 <f, a, f>2 | %21
        r1 | %22
        r1 | %23
        r1 | %24
    % 25-28
        r1 | %25
        r1 | %26
        r1 | %27
        r1 | %28
    % 29-32
        r1 | %29
        r1 | %30
        r1 | %31
        r1 | %32
    % 33-36
        r1 | %33
        r1 | %34
        r1 | %35
        r1 | %36
    % 37-40 
        r1 | %37
        r1 | %38
        r1 | %39 
        r1 | %40 
    % 41-44
        r1 | %41
        r1 | %42
        r1 | %43
        r1 | %44
    % 45-48
        r1 | %45
        r1 | %46
        r1 | %47
        r1 | %48
    % 49-52
        r1 | %49
        r1 | %50
        r1 | %51
        d4 d8. d16 d16 d8. d8 d16 d16 | %52 
    % 53-56
        d4 d8. d16 d16 d8. d8 d16 d16 | %53
        f4 f8. f16 f16 f8. f8 f16 f16 | %54
        \override NoteHead.color = #red
        e4 e8. e16 e16 e8. 
        \override NoteHead.color = #black
        r4 | %55
        r1 | %56
    % 57-60
        r1 | %57
        r1 | %58
        r1 | %59
        r1 | %60
    % 61-64
        r1 | %61
        r1 | %62
        r1 | %63
        r1 | %64
    % 65-68
        r1 | %65
        r1 | %66
        r1 | %67
        r1 | %68
    % 69-72
        r1 | %69
        r1 | %70
        r1 | %71
        r1 | %72
    % 73-76
        r1 | %73
        r1 | %74
        r2 r4 a8 c' | %75
        d'4 r2 r4 | %76
    % 77-80
        r1 | %77 
        r1 | %78
        r1 | %79
        r1 | %80
    % 81-84
        r1 | %81
        r1 | %82
        r1 | %83
        r1 | %84
    % 85-88
        r1 | %85
        r1 | %86
        r1 | %87
        r1 | %88
    % 89-92
        r1 | %89
        r1 | %90
        r1 | %91
        r1 | %92
    % 93-96
        r1 | %93
        r1 | %94 
        r1 | %95
        r1 | %96
    % 97-100
        r1 | 
        r1 |
        r1 |
        r1 |
    % 101-104
        r1 | %101
        r1 | %102
        r1 | %103
        r1 | %104
    % 105-108
        r1 | 
        r1 |
        r1 |
        r1 |
    % 109-112
        r1 |
        r1 |
        r1 |
        r1 |
}
% Verse 
VerseOne = 
    \lyricmode {
        c d e test for lyric 
    }
VerseTwo = 
    \lyricmode {
        \repeat unfold 20 { \skip 1 }
            あ8 の | %8
            ひ み わ た し た | %9
    }

% Main part here ---------------

<<
  \new PianoStaff \with {instrumentName = #"GuZheng"}
  <<
    \new Staff {
        \new Voice = "RH" {
          \voiceOne \RHMusic
        }
        %FIXME: cannot find RH? label problem? 
        %  \new Lyrics \lyricsto "RH" {
        %     \VerseOne
        % }
    }

    \new Staff {
        \new Voice = "LH" {
            \voiceOne \LHMusic
        }
    }
    
  >>
>>