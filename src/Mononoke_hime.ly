\version "2.18.2"
\header {
  title = "もののけ姫"
  subtitle = "Violin and GuZheng"
  composer = "Composer: 久石讓"
}
% 古箏定弦
\new ChoirStaff <<
  \new Staff {
    \tempo "古箏定弦"  
    \omit Score.BarLine
    % \omit \time
    \repeat unfold 3 { s1 }
    % c4 d 
    ees'4 g' aes'
    c'' d'' ees'' g'' aes''
    c'''
    }

  \new Staff {
    \clef bass
    \omit Score.BarLine
    % \omit \time
    c,4 d, ees, g, aes, 
    c d ees g aes 
    c' d'|
    \repeat unfold 9 { s4 }
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
  \new Staff <<
  \set Staff.instrumentName = #"Violin"
  \relative c { 
    %setting
      \time 4/4
      \key c \minor
      \tempo 4 = 70
    %1-4
      r1 r1 r1 r1 | %1-4
    \break %5-8
      \tempo 4 = 80
      <ees'' aes>2. \accent r4 | %5  
      <f bes>2. \accent r4 | %6
      \tempo 4 = 70
      g1 | %7
      \time 3/4
      r4 f, ees8 d8  %8
    \break %9-12
      \time 4/4
      c8 g' g f g4. g8 | %9
      bes8 f8 ~ f2. | %10
      c8 g' g f g4. g8 | %11
      bes2. g8 bes  %12
    \break %13-16
      c4 c8 c c4. c8 | %13
      bes4 f g2 | %14
      f8 f f g f4 c | %15
      g'2 r8 b c d | %16
    \break %17-20
      c8 g' g f g4. bes8 | %17
      f1| %18
      c8 g' g f g4. g8 | %19
      bes2. g8 bes | %20
    \break %21-24
      c4 c8 c c4. c8 | %21
      bes4 f g2 | %22
      f8 f f g f c4 ees8 | %23
      ees2 r2 | %24
    \break %25-28
      f,2 d4 c | %25
      c2 bes4 a | %26
      bes c d4. f8 | %27
      f2 g4 d' | %28
    \break %29-32
      c2 d | %29
      ees1 ~ | %30
      \time 2/4
       ees4 g8 bes | %31
      \time 4/4
      c4 ees d8 g,4 bes8 | %32
    \break %33-36
      c2. g8 bes | %33
      c4 ees d8 g,4 bes8 | %34
      c1 | %35
      c,2. ees16 f g bes  | %36
    \break %37-40
      c,1 | %37
      d1 | %38
      c1 | %39
      d2 r2 | %40
    \break %41-44
      r1 | %41
      r1 | %42
      r1 | %43
      r1 | %44
    \break %45-48
      r1 | %45
      r1 | %46 
      r1 | %47
      r2 b,4 c8 d | %48
    \break %49-52
      ees1 | %49
      d1 | %50
      f1 | %51
      d1 | %52
    \break %53-56
      ees2 g8 f g bes | %53
      f2. ees4 | %54
      f1 | %55
      g4 bes ees bes' | %56
    \break %57-60
      c8 c c d c4. c8 | %57
      ees4 d g,2 | %58
      f4 bes g f8 g | %59 裝飾音
      d'8 d d ees d4. bes8 | %60
    \break %61-64
      ees4 d g,4. g8 | %61
      c8 bes4 aes8 bes2 ~ | %62
      \time 2/4
      bes4 r4 | %63
      \time 4/4 
      r1 | %64
    \break %65-68
      r2 r4 g8 bes | %65
      c4 ees d8 g,4 bes8 | %66
      c1 | %67
      r2 r4 g,8 bes | %68
    \break %69-72
      c4 ees d8 g4 bes8 | %69
      c,1 | %70
      e1 | %71
      c'1 | %72
      }
  >>
% ----------------------------------------
  \new PianoStaff \with {instrumentName = #"GuZheng"}
  <<
    \new Staff \relative {
      %setting
        \key c \minor
        \time 4/4

      %1-4
        g''4 f c d ~ | %1
        d1 |%2
        f4 ees bes c ~ | %3
        c1 | %4
      % \break %5-8
       aes'2. r4 | %5
       bes2. r4 | %6
       g2. d,8 d8 | %7 %add 古箏裝飾音
       g8 d'8 g2 | %8
      % \break %9-12
        <d, ees g>1 | %9
        <d f g> 1 | %10
        <c ees g>1 | %11
        <d f bes>1 | %12
      % \break %13-16
        <f aes c>4 <f aes c> <f aes c>2 | %13
        <d bes'>4 f <bes, g'>2 | %14
        <aes c f>1 | %15
        <a c f g>4 c8 a <b ees g>2 | %16
      % \break %17-20
        <d ees g>4 <d ees g>4 <d ees g>4  <d ees g>4 | %17  
        <d f g>4 <d f g> 4 <d f g>4 <d f g>4 |%18
        <c ees g>4 <c ees g>4 <c ees g>4 <c ees g>4|%19 
         <d f bes>4 <d f bes>4 <d f bes>4 <d f bes>4|%20
      % \break %21-24
        <f aes c>4 <f aes c>4 <f aes c>4 <f aes c>4 | %21
        <d bes'>4 f <g bes,>2 | %22
        <aes, c f>2 <aes c f>2 | %23
        <g bes ees>1 | %24
      % \break %25-28
        c'8 c c d c4. c8 | %25
        ees4 d g, bes | %26
        f bes g f8 g | %27 古箏裝飾音
        d'8 d d ees d4 bes,8 bes' | %28
      % \break %29-32
        ees4 d g,4. g8 | %29 
        c8 bes4 aes8 bes2 | %30
        \time 2/4
        r2 | %31
        \time 4/4
        <ees, aes c>2 <f bes d>| %32
      % \break %33-36
        r1 | %33
        r1 | %34
        c8 g' c2. | %35
        < c, c' >4 
        r8. c32 ees 
        f g bes c c, ees f g 
        bes c c, ees f g bes c   | %36
      % \break %37-40
        c'32
        \repeat unfold 31 {c32} |%37
        r2 bes32 g f d c bes 
        bes'32 g f d c bes
        bes'32 g f d | %38
        bes' g f d c bes g f 
        s4
        r8 g,32 bes 
        c ees f g g, bes c ees f g | %39
        g, bes c ees f g bes c r4 r2 | %40
      % \break %41-44
        c8 g' g f g4. g8 | %41
        bes8 f ~ f2. | %42
        c8 g' g f g4. g8 | %43
        <bes, d bes'>2. <g g'>8 <bes bes'> | %44
      % \break %45-48
        <c ees c'>4 
        <c ees c'>8 <c ees c'> 
        <c ees c'>2 | %45
        <bes f' bes>4 <f bes f'> <g bes g'>2 | %46
        <f c' f>8 <f c' f> <f c'f> <g c g'>
        <f c' f>4 <c c'> | %47
        <g' d' g> <c, c'> <b d b'>2 | %48
      % \break %49-52
        c'2. c'4 | %49
        c, d bes f | %50
        g2. c'4 | %51
        bes, c a f | %52
      % \break %53-56
        aes1 g f ees 
      % \break %57-60
        ees''8 c g f ees'8 c g f | %57
        bes c g f bes c g f | %58
        ees' c g f bes c g f | %59
        bes c g f ees' g, f ees | %60
      % \break %61-64
        r1 | %61
        r1 | %62
        r2 | %63
        c4 ees d8 g,4 bes8 | %64
      % \break %65-68
        <c, ees g c>2 <c f aes c>4 g''8 bes | %65
        c4 ees d8 g,4 bes8 | %66
        c1 | %67
        r1 | %68
      % \break %69-72
        r1 | %69
        \repeat unfold 32 {c32} | %70
        \repeat unfold 32 {c32} | %71
        c1
       }

    \new Staff \relative {
      % setting
        \clef bass
        \key c \minor

      r1 r1 r1 r1
      % \break %5-8
        r1 r r 
        \time 3/4
        r2. |
      % \break %9-12
        <c g' c>1 | %9
        <bes g' bes>1 | %10
        <aes ees' aes>1 | %11
        <g d' g>1 | %12
      % \break %13-16
        f8 c' g' aes c2 | %13
        d,,8 d' f4 ees,8 bes' g'4 | %14
        des,8 aes' f' aes c aes ~ aes4 | %15
        d,,8 a' d a <g d' g>2 | %16
      % \break %17-20
        <c g' c>1 | %17
        <bes g' bes>1 | %18
        <aes ees' g>1| %19
        <g d' g>1 | %20
      % \break %21-25
        f8 c' g' aes c2 | %21
        d,,8 d' f4 ees,8 bes' g' bes, | %22
        f8 c' f g <bes, f'>2 | %24
        ees,8 bes' ees g bes ees g bes | %24
      % \break %25-28
        c,,8 g' c ees g2 | %25
        g,,8 d' g bes d2 | %26
        f,,8 c' aes' c, ees, bes' g' bes, | %27
        g8 d' g bes d2 | %28
      % \break %29-32
        c,8 g' ees' g, bes, g' d' g, | %29
        aes, ees' c' ees, g, ees' g bes' ~ | %30
        \time 2/4
        bes4 r4 | %31
        \time 4/4
        <f,, f'>2 <g g'> | %32
      % \break %33-36
        r1 | %33
        r1 | %34
        r1 | %35
        r1 | %36
      % \break %37-40
        r1 | %37
        r1 | %38
        s4 
        ees''32 c bes g f ees c bes
        s4 s4 |  %39
        r1 | %40
      % \break %41-44
        c8 g' c g d' g, c g | %41
        c,8 g' c g d' g, c g| %42
        aes, ees' c' ees, bes ees aes ees | %43
        g, d' f g bes d bes g | %44
      % \break %45-48
        f,8 c' f c f,8 c' f c | %45
        d, d' f bes  ees,, bes' g' bes, | %46
        des, aes' f aes des, aes' f' aes, | %47
        d, a' f' a, g d' ees f | %48
      % \break %49-52
        r1 r1 r1 r1 
      % \break %53-56  
        r1 r1 r1 r1 
      % \break %57-60
        r1 r1 r1 r1 
      % \break %61-64
        r1 r1 r2 r1 
      % \break %65-68
        r1 r1 r1 r1
      % \break %69-72
      r1 r1 r1 <c' e g c>1
       }
  >>
>>