%
%   Reference
%       1. slur with arrow 
%           https://music.stackexchange.com/questions/107384/slurs-with-arrows-for-glissando-alikes-in-lilypond-how-to
%
%       2. common notation for fretted strings 
%           https://lilypond.org/doc/v2.19/Documentation/notation/common-notation-for-fretted-strings#string-number-indications
%
%       3. Unicode character recognition
%           https://shapecatcher.com

\version "2.18.2"

\header {
    title = "打上花火 （うちあげはなび）"
    subtitle = "GuZheng"
    composer = "DAOKO×米津玄師" % 作曲
    arranger = "莊曉涵×謝岱霖" % 編曲
    tagline = ##f % remove footing 
}

%
% -------------------- Tune up GuZheng --------------------
%
\new ChoirStaff <<
  \new Staff {
    \key f \major
    \tempo "古箏定弦"  
    \omit Score.BarLine
    \repeat unfold 8 { s4 }
    \override NoteHead.color = #darkgreen  
    c'4 
    \override NoteHead.color = #black 
    d' e' f' g' 
    \override NoteHead.color = #darkgreen
    a'  
    \override NoteHead.color = #black
    c''  d'' f'' g'' 
    \override NoteHead.color = #darkgreen
    a'' 
    \override NoteHead.color = #black
    c''' d'''
    }

  \new Staff {
    \clef bass
    \key f \major
    \omit Score.BarLine
    d,4 f, g, 
    \override NoteHead.color = #darkgreen
    a,
    \override NoteHead.color = #black 
    c d f a
    \repeat unfold 13 { s4 }
    }
>>
%
% -------------------- Special symbols --------------------
%
slurArrow =
    \once \override Slur.stencil =
    #(lambda (grob)
        (let* ((slur-dir (ly:grob-property grob 'direction))
            (right-bound (ly:spanner-bound grob RIGHT))
            (right-bound-stem (ly:grob-object right-bound 'stem))
            (right-bound-stem-dir
                (if (ly:grob? right-bound-stem)
                    (ly:grob-property right-bound-stem 'direction)
                    #f))
            (c-ps (ly:grob-property grob 'control-points))
            (frst (car c-ps))
            (thrd (caddr c-ps))
            ;;; corr-values are my choice
            (corr (cond ((not right-bound-stem-dir)
                            '(0 . 0))
                        ((= slur-dir (* -1 right-bound-stem-dir))
                            (cons -0.4  (* 0.2 slur-dir)))
                        (else '(-0.4 . 0.2))))
            (frth (offset-add (cadddr c-ps) corr)))

        (ly:grob-set-property! grob 'control-points
            (append (list-head c-ps 3) (list frth)))

        (let* ((orig (ly:grob-original grob))
            (siblings (ly:spanner-broken-into orig)))
        (if (or (null? siblings)
                (equal? grob (car (last-pair siblings))))
            (let* ((default-stil (ly:slur::print grob))
                    (default-stil-lngth
                        (interval-length (ly:stencil-extent default-stil X)))
                    (delta-x-cps (- (car frth) (car frst)))
                    (diff (- default-stil-lngth delta-x-cps))
                    (delta-iv
                        (cons (- (car frth) (car thrd)) (- (cdr frth) (cdr thrd))))
                    (radians->degree (lambda (radians) (/ (* radians 180) PI)))
                    (ang (radians->degree (atan (cdr delta-iv) (car delta-iv))))
                    (arrowhead (ly:font-get-glyph (ly:grob-default-font grob)
                                                "arrowheads.open.01"))
                    (rotated-arrowhead (ly:stencil-rotate arrowhead ang 0 0))
                    (arrowhead-lngth
                        (interval-length (ly:stencil-extent rotated-arrowhead X))))
                    
                (ly:stencil-add
                default-stil
                (ly:stencil-translate
                    rotated-arrowhead
                    ;; Ugh, 3.8 found by trial and error
                    (cons (+ diff (/ arrowhead-lngth 3.8) (car frth))
                        (+ (cdr frth) 0)))))
                        
                (ly:slur::print grob)))))
%
% -------------------- Music score --------------------
%
% Right hand
RHMusic = {
    \key f \major
    \time 4/4
    \tempo 4 = 96  

    % 1-4
        %1
            % FIXME: stem direction
            % \override Stem.neutral-direction = #down 
            \override Stem.direction = #down
            g''8 ^"Introduction" \mf a'' c''' f'' g'' a'' c''' f''  | 
        %2
            g''8 a'' c''' d''' g'' a'' d'' f''  | 
        %3
            g''8 \accent a'' c''' f'' g'' a'' c''' f''  | 
        %4
            g''8 a'' c''' d''' g'' a'' d'' f''  | 
    % 5-8
        %5
            \override Stem.direction = #up
            g'8 \accent a' c'' f' g' a' c'' f'  | 
        %6
            g'8 a' c'' f' g' a' c'' f'  | 
        %7
            g'8\> a' c'' f'\! g'\< a' c'' f'\!  | 
        %8
            g'8_\markup{ \italic rit.} a' c'' f' 
            g'\open a'\open  \fermata 
            \mark \markup { \box A } r4   | 
    % 9-12
        %9
            r4 f'8( g'4 \autoBeamOff f'8) 
            \autoBeamOn c'8 
            \override NoteHead.color = #red
            bes8 
            \override NoteHead.color = #black | 
        %10 
            a8 c'8 \slurArrow \slurDown e'8( f'8)  r4 f'8 e' | 
        %11
            d'4 \accent f' e'8 c'4 \slurArrow \slurDown a8(  | 
        %12
            c'2.:32)  a8 c'8 | 
    % 13-16
        %13
            d'4^\markup{ \char ##x2335 } \prall  f'8^( g'4 \autoBeamOff f'8) 
            \autoBeamOn c'8 
            \override NoteHead.color = #red
            bes 
            \override NoteHead.color = #black | 
        %14 
            a8 c'8 \slurArrow \slurDown e'8( f')^\markup{ \char ##x2335 } \prall  r4 f'8e' | 
        %15    
            d'4 f' e'8 c' c' \slurArrow \slurDown c'( |
        %16 
            d'4:32) r2 d'8_\p e' | 
    % 17-20
        %17
            f'4.:32 e'8 d' e' f'4^\markup{ \char ##x22B9 }( | 
        %18
            f'8 ^. ^"mute") e'-1 d'-3 e'-2 f'-1 e'-2 c'-4 d'-3 | 
        %19
            c'2^\markup{ \char ##x2335 }  c'2^\markup{ \char ##x2335 }| 
        %20
            r2 
            \arpeggioNormal<e' f' g' a'>4_\markup{\circle{L}}\arpeggio 
            d'8 e' | 
    % 21-24
        %21
            f'4.:32 e'8 d' e' f'4^\markup{ \char ##x22B9 }( | 
        %22
            f'8^. ^"mute") e'-1 d'-4 e'-3 f'-2 g'-1 a'-2 
            \override NoteHead.color = #red 
            bes'-1 |
        %23
            bes'8 
            \override NoteHead.color = #black 
            f' f'8 g'16 a' g'8 f' f'4 | 
        %24
            r2. a'8_\f c''16 a' | 
    % 25-28
        g'8 \accent f' 
        d'16 f'8 g'16^~ 
        \slurArrow \slurDown g'8(\grace{a'16)} r8 a'8 c''16 a' | %25 
        g'8 \accent  f' c'16 f'8 f'16_~ f'4 \prall  a'8 c''16 a' | %26 
        g'8 \accent r8 a'16 c''8 c''16~ c''16 d''8. c''16 
        \override NoteHead.color = #red 
        bes' 
        \override NoteHead.color = #black
        a'8( | %27
        a'2:32) r4 a'8 c''16 a' | %28 
    % 29-32
        g'8 \accent  f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | %29
        g'8 \accent  f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | %30 
        d'8. d'16 g'4 e'8 d' e' e' | %31
        e'8 f'4. f'4 r4 | % 32
    % 33-36
        g'8^\mp a' c'' f' g'8 a' c'' f'  | %33
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
% Left hand
LHMusic = {
    \clef bass
    \key f \major
    %1-4
        %1
            c2 a,   | 
        %2
            g, f,   |
        %3
            <c a,>2 <a, g,>2    |
        %4
            <g, f,>2 <f, d,>2   |
    %5-8
        %5
            f,8 g, a, c f,8 g, a, c |
        %6
            <c f,>2 <a, g,> | 
        %7
            f,2 f, | 
        %8
            r2. a,8\open c\open |
    % 9-12
        %9
            d4\open r2.| 
        %10
            r4 f,2 r4 | 
        %11
            d,8-5 a,-3 c-2 d-1 r4. <a, c>8_\markup{\circle{R}} | 
        %12
            r1 | 
    % 13-16
        %13
            d1 |
        %14
            r4. f4. r4 | 
        %15
            d,8 a, <c d>4 r2 | 
        %16
            r1 | 
    % 17-20
        %17
            <d, d>2 <f, f>2 | 
        %18
            r4 d, f, a, | 
        %19
            c8 f f d' c8 \slurArrow \slurDown f8(  
            \override NoteHead.color = #red
            g8) g 
            \override NoteHead.color = #black  | 
        %20
            \acciaccatura a,16 a2:32 r2 | 
    % 21-24
        <d, a, f>2\arpeggio <f, a, f>2 | %21
        r4 <d, d>4 <f, f>2(  | %22
        <f, f>4) <f a c'>4\arpeggio <c a,>4 <f, f>4 | %23
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
        r1 | %97
        r1 | %98
        r1 | %99
        r1 | %100
    % 101-104
        r1 | %101
        r1 | %102
        r1 | %103
        r1 | %104
    % 105-108
        r1 | %105
        r1 | %106
        r1 | %107
        r1 | %108
    % 109-112
        r1 | %109
        r1 | %110
        r1 | %111
        r1 | %112
}
% Verse 
Verse = \lyricmode {
    % FIXME:
    %https://lilypond.org/doc/v2.20/Documentation/notation/common-notation-for-vocal-music
    %https://music.stackexchange.com/questions/98554/disaligning-lyrics-to-a-melody-with-lilypond
    % 1-8
        \repeat unfold 2
        % 8 
        % { \skip 1 }     
        あ8 の 
    % 9-12
        % 9  
            ひみわたした 
        % 10 
            なぎさを，いま
        % 11
            もおもいだすんだ。
        % 12
            すな
    % 13-16 
        % 13
            のうえにきざん
        % 14
            だことば，きみ
        % 15
            のうしろすがた。
        % 16
            より
    % 17-20
    % 21-24
    % 25-28
    % 29-32
    % 33-36
}

% Main part here ---------------
\score{
    <<
        \new PianoStaff \with {instrumentName = #"GuZheng"}
        <<
            \new Staff {
                \new Voice {
                    \voiceOne \RHMusic
                }
            }
            \new Staff {
                \new Voice {
                    \voiceOne \LHMusic
                }
            }
        >>
        
        % \new Lyrics \Verse
    >>

    \layout{
        \context{
            \Voice 
            %FIXME: stem direction 
            %http://lilypond.org/doc/v2.18/Documentation/notation/inside-the-staff
            
            \consists "Melody_engraver"
            \override Stem.neutral-direction = #'()
        }
    }

    \midi{
        \context {
            \Voice
            \remove "Dynamic_performer"
        }
    }
}