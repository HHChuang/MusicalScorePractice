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
            \mark \markup { \box A1 } r4   | 
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
            d'4:32) bes'2\rest d'8_\p e' | 
    % 17-20
        %17
            f'4.:32 e'8 d' e' f'4^\markup{ \char ##x22B9 }( | 
        %18
            f'8 ^. ^"mute") e'-1 d'-3 e'-2 f'-1 e'-2 c'-4 d'-3 | 
        %19
            c'8^\markup{ \char ##x2335 } a a d'  
            c'8^\markup{ \char ##x2335 } a a bes | 
        %20
            bes'2\rest
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
            bes'2. 
            \mark \markup { \box B1 } a'8_\f c''16 a' | 
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
            g'8 \accent  f' d'16 f'8 f'16( f'8) r8 f'16 e' d' e' | 
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
            d'8 e'16-1 f'-2 e'8-1 f'16-3 g'-2 a'8-1 g'16-1 f'-2 e'8-3 c'16 c'(| 
        % 40 
            c'2.) \prall r8 f'16 g' | 
    % 41-44
        % 41
            a'8 g'16 f' f'8 d'16 e' f'8 e'16 d' c'8 c'16 c' | 
        % 42
            d'16 d' e' f' e' c'-3 c'-2 d'-1 c'-2 c'-3 r8 
            d'8. c'16( | 
        % 43
            c'8) d'8( d'16) f'8. g'8. a'16( a'8) 
            <g' e'>8 | 
        % 44
            f'8 f'4.:32 b'2\rest |
    % 45-48
        % 45
            d''4 c''8 
            \override NoteHead.color = #red
            bes' 
            \override NoteHead.color = #black
            <d' e' a'>4\arpeggio  g'16-3 a'-2 
            \override NoteHead.color = #red
            bes'8-1(
            \override NoteHead.color = #black
            % f' >8(| 
        % 46
            \override NoteHead.color = #red
            bes'16) 
            \override NoteHead.color = #black
            a'-1 g'-2 f'-3( f') g' a' 
            \override NoteHead.color = #red
            bes'( bes') 
            \override NoteHead.color = #black
            a' g' f'( f') d' e' f'( | 
        % 47
            f'16) e' d' c'( c'8) c' 
            d'8.^\accent f'16( f'8) e'( | 
        % 48
            e'16) c'8 a16( a8.) d'16:32( d'2) | 
    % 49-52
        % 49
            d''4 c''8 
            \override NoteHead.color = #red
            bes' 
            \override NoteHead.color = #black
             <d' e' a'>4\arpeggio  g'16 a' 
            \override NoteHead.color = #red
            bes'8:32( | 
        % 50 
            bes'4) 
            \override NoteHead.color = #black
            a'16 g' a'8:32( a'2) | 
        % 51
            r4. 
            \override NoteHead.color = #red
            bes'8 
            \override NoteHead.color = #black
            a' g' f' <c' d' f'>\arpeggio | 
        % 52
            <d d'>4 d'8. d'16( d'16) d'8. d'8 d'16 d'16 | 
    % 53-56
        % 53
            <d d'>4 d'8. d'16( d'16) d'8. d'8 d'16 d'16 | 
        % 54
            <f f'>4 f'8. f'16( f'16) f'8. f'8 f'16 f'16 | 
        % 55
            e'8( e'4.:32)  r4 
            \mark \markup { \box B2 } a'8 c''16 a' | 
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
            e'8 f'4.:32( f'4) r4 | 
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
            g''8 a'' c''' f'' g''8 a'' 
            \mark \markup { \box A2 } r4| 
        % 76
            r4 f'8( g'4 \autoBeamOff f'8) 
            \autoBeamOn c'8 
            \override NoteHead.color = #red
            bes8 
            \override NoteHead.color = #black | 
    % 77-80
        % 77 
            a8 c'8 \slurArrow \slurDown e'8( f'8)  r4 f'8 e' |
        % 78
            d'4 \accent f' e'8 c'4 \slurArrow \slurDown a8^\markup{ \char ##x2335 } (  |
        % 79
            c'2.:32)  a8 c'8 | 
        % 80 
            d'4^\markup{ \char ##x2335 } \prall  f'8^( g'4 \autoBeamOff f'8) 
            \autoBeamOn c'8 
            \override NoteHead.color = #red
            bes 
            \override NoteHead.color = #black | 
    % 81-84
        % 81
            a8 c'8 \slurArrow \slurDown e'8( f')^\markup{ \char ##x2335 } \prall  r4 f'8e' | 
        % 82
            d'4 f' e'8 c' c' \slurArrow \slurDown c'( |
        % 83
            d'4:32) r2 
            \mark \markup { \box B3 } a'8 c''16 a' | 
        % 84
            g'8 \accent f' 
            d'16 f'8 g'16(g'8) 
            r8 a'8 c''16 a' | 
    % 85-88
        % 85
            g'8 \accent  f' c'16 f'8 f'16_~ f'4 a'8 c''16 a' | 
        % 86
            <g' c'' d'' g''>4\arpeggio a'16 c''8 c''16~ c''16 <d'' a'' d'''>8.\arpeggio  c''16 
            \override NoteHead.color = #red 
            bes' 
            \override NoteHead.color = #black
            a'8^( |
        % 87
            \acciaccatura a16 a'2:32) r4 a'8  c''16 a' | 
        % 88
            g'8 \accent  f' 
            d'16 f'8 g'16( g'8) 
            r8 a'8 c''16 a' |
    % 89-92
        % 89 
            g'8 \accent  f' d'16 f'8 f'16 f'8 r8 f'16 e' d' e' | 
        % 90 
            d'8. d'16 g'4 <a e'>8 d'8^\markup{ \char ##x2335 } e'8 e' |
        % 91
            e'8 f'4.:32( f'4) r4 |
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
            <c f c'>2\arpeggio r2 | 
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
            bes
            \override NoteHead.color = #black | 
        % 103
            <c f c'>2\arpeggio r2 | 
        % 104
        d'4 d'16 e' f'8 g'4 a'8 f' | 
    % 105-108
        % 105
            f'4 a'16 g' f'8 g'4 c''8 a' | 
        % 106
            d'4. a'8 g'4. f'16 g' | 
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
            g''8 a'' f'' g'' 
            g''8 a'' g'4\open
            \bar "|." 
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
            R2. a,8^\open c^\open |
    % 9-12
        %9
            d4^\open R2.| 
        %10
            r4 f,2 r4 | 
        %11
            d,8-5 a,-3 c-2 d-1 r4. c8 | 
        %12
            R1 | 
    % 13-16
        %13
            d1 |
        %14
            r4. f4. r4 | 
        %15
            d,8 a, <c d>4 r2 | 
        %16
            R1 | 
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
            d16 a d' a g,4
            <a, c'>4 | 
        % 30 
            c16 f c' f 
            c16 f c' f  f,4 
            <a f>8 <f d>8| 
        % 31
            <d c>4 g,4 r8 d4. | 
        % 32
            r8 <f, a, f>4.\arpeggio f,2 | 
    % 33-36
        % 33
            d8(^\accent f4 f8) d8( f4 f8)  | 
        % 34
            c8(^\accent f4 f8) c8( f4 f8) | 
        % 35
            a,8(^\accent f4 f8) a,8( f4 f8) | 
        % 36
            a,8( f4 f8) <a, c f>2\arpeggio | 
    % 37-40 
        % 37 
            <a d'>4\arpeggio <d f>\arpeggio <c f>\arpeggio <a, d>\arpeggio| 
        % 38 
            <d f>4\arpeggio c16 f8.  <c d f>2\arpeggio| 
        % 39
            <d a>4\arpeggio <f c'>4\arpeggio <a d'>4\arpeggio <c a c'>4\arpeggio| 
        % 40
            <f, a, c>1\arpeggio | 
    % 41-44
        % 41
            <a d'>4\arpeggio <d f>\arpeggio <c f>\arpeggio <a, c>4\arpeggio |  
        % 42
            a,16 c8 c16 g,16 c8 c16 <g, a, c>4 
            <d, f a>8.\arpeggio <d f>16\arpeggio(| 
        % 43
            \autoBeamOff
            <d f>8) <f a>8.\arpeggio 
            <f, a c'>8.\arpeggio <d' e'>8.\arpeggio  <f' g'>8.\arpeggio 
             g,8 |  
        % 44
            r8 f,8 \glissando f8 \glissando f,8
            r2  \autoBeamOn| 
    % 45-48
        % 45
            <d f d'>1\arpeggio  | 
        % 46
            R1 | 
        % 47
            R2 <d, d f >2\arpeggio | 
        % 48
            R1  | 
    % 49-52
        % 49
            <d f d'>1\arpeggio | 
        % 50
            R1 | 
        % 51
            R1 | 
        % 52
            d,1_\markup{ \char ##x30ad } |
    % 53-56
        % 53
            d,1_\markup{ \char ##x30ad }  | 
        % 54
            f,1_\markup{ \char ##x30ad } | 
        % 55
            r2. 
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
            r8 <f, a, f>4.\arpeggio f,2 | 
        % 64
            R2 r8 c8 a,16 g, f, g,  | 
    % 65-68
        % 65
            g,8 R2  c8 a,16 g, f, g, | 
        % 66
            g,8  R2  c8 a,16 g, f, g, | 
        % 67
            g1 | 
        % 68
            R2 r8 c8 a,16 g, f, g, | 
    % 69-72
        % 69
            g,8 R2  c8 a,16 g, f, g, | 
        % 70
            g1 | 
        % 71
            R1 | 
        % 72
            d'2^\accent f'4.( f'8) | 
    % 73-76
        % 73
            g'2 c''2    | 
        % 74
            d'2^\accent f'4.( f'8)| 
        % 75
            g'2.
            a8 c' |
        % 76
            d'4 R2. 
    % 77-80
        % 77
            r4 f,2 r4 | 
        % 78
            d,8-5 a,-3 c-2 d-1 r4. c8 | 
        % 79
            R1 | 
        % 80
            d1 | 
    % 81-84
        % 81
            r4. f4. r4  | 
        % 82
            d,8 a, <c d>4 R2 | 
        % 83
            R2. <a, c'>4  | 
        % 84
            c16 f c' f 
            d16 a d' a g,4 
            <a, c'>4 | 
    % 85-88
        % 85
            c16 f c' f c16 f c' f f,4 <a, a>4  |
        % 86
            r4 <a, a>2. |
        % 87
            % TODO: how to remove beam? 
            \autoBeamOff
            \override Glissando.style = #'zigzag
            a'8 \glissando  a,8 \glissando a'8 \glissando a,8
            \autoBeamOn
            r4 
            <a, c'>4 | 
        % 88
            c16 f c' f 
            d16 a d' a g,4
            <a, c'>4 | 
    % 89-92
        % 89
            c16 f c' f 
            c16 f c' f  f,4 
            <a f>8 <f d>8| 
        % 90
            <d c>4 g,4 r8 d4. | 
        % 91
            r8 <f, a, f>4.\arpeggio f,2 | 
        % 92
            <d, a, c>2 <g, a, c>2 | 
    % 93-96
        % 93
            <f, c d>2 <g, a, c>2    |      
        % 94
            <a, f a>2 <d, a, c>2    |
        %95
            r1 |
        % 96
            <d, a, c>2 <g, a, c>2   | 
    % 97-100
        % 97
            <f, c d>2 <g, a, c>2    |
        % 98
            <d, a, c>2 <g, a, c>2   |
        % 99
            <a, f a>2 <f, c d>2     |
        % 100
            <d, a, c>2 <g, a, c>2   | 
    % 101-104
        % 101
            <f, c d>2 <g, a, c>2    |
        %102
            <a, f a>2 <d, a, c>2    |
        %103
            r1 |
        % 104
            <d, a, c>2 <g, a, c>2   |
    % 105-108
        % 105
            <f, c d>2 <g, a, c>2    |
        % 106
            <d, a, c>2 <g, a, c>2   |
        % 107
            <a, f a>2 <f, c d>2     |
        % 108
            d'2^\accent f'4.( f'8) | 
    % 109-112
        % 109
            g'2 c''2    |
        % 110
            d'2^\accent f'4.( f'8)|
        % 111
            g'2 c''2    |
        %112
            f1
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