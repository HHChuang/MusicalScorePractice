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
            d'4 \accent f' e'8 c'4 \slurArrow \slurDown a8^\markup{ \char ##x2335 } (  | 
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
            r2. \mark \markup { \box B1 } a'8_\f c''16 a' | 
    % 25-28
        % 25
            g'8 \accent f' 
            d'16 f'8 g'16(g'8) 
            r8 a'8 c''16 a' | 
        % 26
            g'8 \accent  f' c'16 f'8 f'16_~ f'4 a'8 c''16 a' | 
        % 27
            <g' c'' d'' g''>4\arpeggio a'16 c''8 c''16~ c''16 <d'' a'' d'''>8.\arpeggio  c''16 
            \override NoteHead.color = #red 
            bes' 
            \override NoteHead.color = #black
            a'8^( |
        % 28
            \acciaccatura a16 a'2:32) r4 a'8  c''16 a' | 
    % 29-32
        % 29 
            g'8 \accent  f' 
            d'16 f'8 g'16( g'8) 
            r8 a'8 c''16 a' |
        % 30 
            g'8 \accent  f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | 
        % 31
            d'8. d'16 g'4 <a e'>8 d'8^\markup{ \char ##x2335 } e'8 e' |
        % 32
            e'8 f'4.:32( f'4) r4 | 
    % 33-36
        % 33
            g'8_\mp a' c'' f' g'8 a' c'' f'  |
        % 34
            g'8 a' c'' f' g'8 a' c'' f'  | 
        % 35
            g'8 a' c'' f' g'8 a' c'' f'  |
        % 36 
            g'8 a' c'' f' g'8\fermata a'\fermata
             r8 f'16 g'  |
    % 37-40 
        % 37
            a'8 g'16 f' f'8 d'16 e' f'8 e'16 d' c'8 a16 c' | 
        % 38 
            d'8 e'16-2 f'-1  e'-1 c'-3 c'-2 d'-1 c'4-2 a16 a c' c' | 
        % 39  
            d'8 e'16-1 f'-2 e'8-1 f'16-3 g'-2 a'8-1 g'16-1 f'-2 e'8-3 c'16 c'| 
        % 40 
            c'2. \prall r8 f'16 g' | 
    % 41-44
        % 41
            a'8 g'16 f' f'8 d'16 e' f'8 e'16 d' c'8 c'16 c' | 
        % 42
            d'16 d' e' f' e' c'-3 c'-2 d'-1 c'-2 c'-3 r8 d'8. c'16 | 
        % 43
            c'8 d' d'16 f'8. g'8. a'16 a'8 g' | 
        % 44
        f'8 f'4. r2 |
    % 45-48
        % 45
            d''4 c''8 
            \override NoteHead.color = #red
            bes' 
            \override NoteHead.color = #black
            a'4 g'16 a' 
            \override NoteHead.color = #red
            bes'8| 
        % 46
            bes'16 
            \override NoteHead.color = #black
            a' g' f' f' g' a' 
            \override NoteHead.color = #red
            bes' bes' 
            \override NoteHead.color = #black
            a' g' f' f' d' e' f' | 
        % 47
            f'16 e' d' c' c'8 c' d'8. f'16 f'8 e' | 
        % 48
            e'16 c'8 a16 a8. d'16 d'2 | 
    % 49-52
        % 49
            d''4 c''8 
            \override NoteHead.color = #red
            bes' 
            \override NoteHead.color = #black
            a'4 g'16 a' 
            \override NoteHead.color = #red
            bes'8 | 
        % 50 
            bes'4 
            \override NoteHead.color = #black
            a'16 g' a'8 a'4 r4 | 
        % 51
            r4. 
            \override NoteHead.color = #red
            bes'8 
            \override NoteHead.color = #black
            a' g' f' f' | 
        % 52
            r1 | 
    % 53-56
        % 53
            r1 | 
        % 54
            r1 | 
        % 55
            r2.  \mark \markup { \box B2 } a'8 c''16 a' | 
        % 56
            g'8 f' 
            d'16 f'8 g'16(g'8)  
            r8 a'8 c''16 a'16 | 
    % 57-60
        % 57
            g'8 f' d'16 f'8 f'16(f'8) 
            r8 a'8 c''16 a'16 | 
        % 58 
            <g' c'' d'' g''>4\arpeggio a'16 c''8 c''16~ c''16 <d'' a'' d'''>8.\arpeggio  c''16 
            \override NoteHead.color = #red 
            bes' 
            \override NoteHead.color = #black
            a'8^( | 
        % 59
            \acciaccatura a16 a'2:32) r4 
            a'8 c''16 a' | 
        % 60
            g'8 f' d'16 f'8 g'16( g'8) r8 a'8 c''16 a' | 
    % 61-64
        % 61 
            g'8 f' d'16 f'8 f'16( f'8) 
            r8 f'16 e' d' e' | 
        % 62
            d'4 g' e'8 c' a e' | 
        % 63
            e'8 f'4. r2 | 
        % 64
            r8 c'' a'16 g' f' g' g'2 | 
    % 65-68
        % 65
            r8 c'' a'16 g' f' g' g'2 | 
        % 66
            r8 c'' a'16 g' f' g' g'2 | 
        % 67
            r8 d'' c''16 
            \override NoteHead.color = #red
            bes' bes' 
            \override NoteHead.color = #black
            c'' c''2 | 
        % 68
            r8 c'' a'16 g' f' g' g'2 | 
    % 69-72
        % 69
            r8 c'' a'16 g' f' g' g'2 | 
        % 70
            r8 c'' a'16 g' f' g' g'8 f'16 g' a'8 
            \override NoteHead.color = #red
            bes' 
            \override NoteHead.color = #black | 
        % 71
            g'8 g'4. r2 | 
        % 72 
            g''8 a'' c''' f'' g''8 a'' c''' f'' |
    % 73-76
        % 73
            g''8 a'' c''' f'' g''8 a'' c''' f''| 
        % 74
            g''8 a'' c''' f'' g''8 a'' c''' f''| 
        % 75
            g''8 a'' c''' f'' g''8 a'' r4| 
        % 76
            r4 f'8 g' g' f' c' 
            \override NoteHead.color = #red
            bes 
            \override NoteHead.color = #black | 
    % 77-80
        % 77 
            a8 c' f'4 r4 f'8 e' | 
        % 78
            d'4 f' e'8 c'4 c'8  | 
        % 79
            c'4 r2 a8 c' | 
        % 80 
            d'4 f'8 g' g' f' c' 
            \override NoteHead.color = #red
            bes 
            \override NoteHead.color = #black | 
    % 81-84
        % 81
            a8 c' e' f' r4 f'8 e' | 
        % 82
            d'4 f' e'8 c' c' d' | 
        % 83
            d'4 r2 a'8 c''16 a' | 
        % 84
            g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | 
    % 85-88
        % 85
            g'8 f' c'16 f'8 f'16 f'8 r8 a'8 c''16 a' | 
        % 86
            g'8 r8 a'16 c''8 c''16 c''16 d''8. c''16 
            \override NoteHead.color = #red 
            bes' 
            \override NoteHead.color = #black
            a'8 | 
        % 87
            a'2 r4 a'8 c''16 a' | 
        % 88
            g'8 f' d'16 f'8 g'16 g'8 r8 a'8 c''16 a' | 
    % 89-92
        % 89 
            g'8 f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | 
        % 90 
            d'8. d'16 g'4 e'8 d' e' e' | 
        % 91
            e'8 f'4. r2 | 
        % 92 
            d'4 d'16 e' f'8 g'4 a'8 f' | 
    % 93-96
        % 93
            f'4 a'16 g' f'8 g'4 c''8 a' | 
        % 94
            a'4 f'8 c' d'4 c'8 
            \override NoteHead.color = #red 
            bes 
            \override NoteHead.color = #black |  
        % 95
            c'2 r2 | 
        % 96
            d'4 d'16 e' f'8 g'4 a'8 f' |
    % 97-100
        % 97
            f'4 a'16 g' f'8 g'4 c''8 a' | 
        % 98
            d'4. a'8 g'4. f'16 g' |
        % 99
            a'4. g'16 f' f'2 | 
        % 100
            d'4 d'16 e' f'8 g'4 a'8 f' | 
    % 101-104
        % 101
            f'4 a'16 g' f'8 g'4 c''8 a' | 
        % 102
            a'4 f'8 c' d'4 c'8 
            \override NoteHead.color = #red 
            bes' 
            \override NoteHead.color = #black | 
        % 103
            c'2 r2 | 
        % 104
        d'4 d'16 e' f'8 g'4 a'8 f' | 
    % 105-108
        % 105
            f'4 a'16 g' f'8 g'4 c''8 a' | 
        % 106
            d''4. a'8 g'4. f'16 g' | 
        % 107 
            a'4. g'16 f' f'2 | 
        % 108 
            g''8 a'' c''' f'' g''8 a'' c''' f'' | 
    % 109-112
        % 109 
            g''8 a'' c''' f'' g''8 a'' c''' a'' | 
        % 110
            g''8 a'' c''' f'' g''8 a'' c''' f'' | 
        % 111
            g''8 a'' c''' f'' g''8 a'' c''' f'' | 
        % 112
            g''8 a'' f'' g'' r2 \bar "|." 
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
            r2. a,8^\open c^\open |
    % 9-12
        %9
            d4^\open r2.| 
        %10
            r4 f,2 r4 | 
        %11
            d,8-5 a,-3 c-2 d-1 r4. c8 | 
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
        % 21
            <d, a, f>2\arpeggio <f, a, f>2 |
        % 22
            r4 <d, d>4 <f, f>2(  |
        % 23
            <f, f>4) <f a c'>4._\markup{\circle{R}}\arpeggio <c a,>8 <f, f>4 | 
        %24
            r2. <a, c'>4 | 
    % 25-28
        % 25 
            c16 f c' f 
            d16 a d' a g,4 
            <a, c'>4 | 
        % 26
            c16 f c' f c16 f c' f f,4 <a, a>4 | 
        % 27
            r4 <a, a>2. | 
        % 28
            % TODO: how to remove beam? 
            \autoBeamOff
            \override Glissando.style = #'zigzag
            a'8 \glissando  a,8 \glissando a'8 \glissando a,8
            \autoBeamOn
            r4 
            <a, c'>4 | 
    % 29-32
        % 29
            c16 f c' f 
            d16 a d' a <d g d'>4\arpeggio 
            <a, c'>4 | 
        % 30 
            c16 f c' f c16 f c' f  <f, c f>4\arpeggio <a f>8 <f d>8| 
        % 31
            <d c>4 g,4 r8 d4. | 
        % 32
            r8 <f, a, f>4.\arpeggio f,2 | 
    % 33-36
        % 33
            d8^( f4 f8) d8^( f4 f8)  | 
        % 34
            c8^( f4 f8) c8^( f4 f8) | 
        % 35
            a,8^( f4 f8) a,8^( f4 f8) | 
        % 36
            a,8^( f4 f8) <a, c f>2\arpeggio | 
    % 37-40 
        % 37 
            <a d'>4\arpeggio <d f>\arpeggio <c f>\arpeggio <a, d>\arpeggio| 
        % 38 
            <d f>4\arpeggio c16 f8 f16 <c d f>2\arpeggio| 
        % 39
            <d a>4\arpeggio <f c'>4\arpeggio <a d'>4\arpeggio <c a c'>4\arpeggio| 
        % 40
            <f, a, c f>1\arpeggio | 
    % 41-44
        % 41
            <a d'>4\arpeggio <d f>\arpeggio <c f>\arpeggio <a, c>4\arpeggio |  
        % 42
            a,16 c8 c16 g,16 c8 c16 <g, a, c>4 r4| 
        % 43
            r1 |  
        % 44
            r1 | 
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
        % 53
            d4 d8. d16 d16 d8. d8 d16 d16 | 
        % 54
            f4 f8. f16 f16 f8. f8 f16 f16 | 
        % 55
            \override NoteHead.color = #red
            e4 e2 
            \override NoteHead.color = #black
            <a, c'>4 | 
        % 56
            c16 f c' f 
            d16 a d' a g,4 
            <a, c'>4 | 
    % 57-60
        % 57
            c16 f c' f c16 f c' f f,4 <a, a>4 | 
        % 58
            r4 <a, a>2. | 
        % 59
            \autoBeamOff
            \override Glissando.style = #'zigzag
            a'8 \glissando  a,8 \glissando a'8 \glissando a,8
            \autoBeamOn
            r4 <a, c'>4  | 
        % 60
            c16 f c' f 
            d16 a d' a <d g d'>4\arpeggio 
            <a, c'>4 | 
    % 61-64
        % 61
            c16 f c' f c16 f c' f  <f, c f>4\arpeggio <a f>8 <f d>8 |
        % 62 
            <d c>4 r2. | 
        % 63
            r8 <f, a, f>4.\arpeggio r2 | 
        % 64
            r1 | 
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

Null = {
    \time 4/4
    c4 c4 c4 c4 
    c4 c4 c4 c4 
    c4 c4 c4 c4 
    c4 c4 c4 c4 
}

% Verse 
Verse = \lyricmode {
    % FIXME:
    %https://lilypond.org/doc/v2.20/Documentation/notation/common-notation-for-vocal-music
    %https://music.stackexchange.com/questions/98554/disaligning-lyrics-to-a-melody-with-lilypond
    % 1-8
        % \repeat unfold 2
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
                    \set midiInstrument = #"acoustic guitar (nylon)"
                    \voiceOne \RHMusic
                }
            }
            \new Staff {
                % \new Voice {
                %     \voiceTwo \LHMusic
                % }
                \new Voice \LHMusic
                % FIXME:
                % \new NullVoice = "singer" \Null
            }
            % \new Lyrics \lyricsto singer \Verse
        >>
        
        % \new Lyrics \lyricsto singer \Verse
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

    % \midi{
    %     % TODO: multiple soundtracks
    %     % https://music.stackexchange.com/questions/108555/how-to-split-multi-voice-lilypond-scores-to-multiple-midi-outputs-e-g-for-choi
    %     % https://lilypond.org/doc/v2.19/Documentation/notation/midi-channel-mapping
    %     \context {
    %         \Staff
    %         midiChannelMapping = #"RHMusic"
    %         \remove "Dynamic_performer"
    %     }
    %     \context {
    %         \Staff
    %         midiChannelMapping = #"LHMusic"
    %         \remove "Dynamic_performer"
    %     }
    % }
}