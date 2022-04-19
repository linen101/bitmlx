#lang bitml

(debug-mode)

(participant "A" "txA")
(participant "B" "txB")

(contract
 (pre
  (deposit "A" 1 "x1")
  (secret "A" a "000a")
  (deposit "B" 1 "y1")
  (secret "B" b "000b")
  (deposit "A" 2 "x1col")
  (secret "A" s1Ab "001Ab")
  (secret "A" s2Ab "002Ab")
  (secret "A" s3Ab "003Ab")
  (secret "A" s1Ad "001Ad")
  (secret "A" s2Ad "002Ad")
  (secret "A" s3Ad "003Ad")
  (deposit "B" 2 "y1col")
  (secret "B" s1Bb "001Bb")
  (secret "B" s2Bb "002Bb")
  (secret "B" s3Bb "003Bb")
  (secret "B" s1Bd "001Bd")
  (secret "B" s2Bd "002Bd")
  (secret "B" s3Bd "003Bd")
  )

 (choice
  (reveal (s1Ad a) (choice
                    (reveal (s2Ad b) (split
                                       (3 -> (split
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       )
                                       (3 -> (split
                                               (1 -> (withdraw "B"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       ))
                                     )
                    (reveal (s2Bd b) (split
                                       (3 -> (split
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       )
                                       (3 -> (split
                                               (1 -> (withdraw "B"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       ))
                                     )
                    (after 10 (reveal (s2Ab) (split
                                               (5 -> (withdraw "B")))
                                             )
                     )
                    (after 10 (reveal (s2Bb) (split
                                               (5 -> (withdraw "A")))
                                             )
                     )
                    (after 20 (split
                                (2 -> (withdraw "A"))
                                (2 -> (withdraw "A"))
                                (2 -> (withdraw "B")))
                     )
                    ))
  (reveal (s1Bd a) (choice
                    (reveal (s2Ad b) (split
                                       (3 -> (split
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       )
                                       (3 -> (split
                                               (1 -> (withdraw "B"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       ))
                                     )
                    (reveal (s2Bd b) (split
                                       (3 -> (split
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       )
                                       (3 -> (split
                                               (1 -> (withdraw "B"))
                                               (1 -> (withdraw "A"))
                                               (1 -> (withdraw "B")))
                                       ))
                                     )
                    (after 10 (reveal (s2Ab) (split
                                               (5 -> (withdraw "B")))
                                             )
                     )
                    (after 10 (reveal (s2Bb) (split
                                               (5 -> (withdraw "A")))
                                             )
                     )
                    (after 20 (split
                                (2 -> (withdraw "A"))
                                (2 -> (withdraw "A"))
                                (2 -> (withdraw "B")))
                     )
                    ))
  (after 5 (reveal (s1Ab) (split
                            (5 -> (withdraw "B")))
                          )
   )
  (after 5 (reveal (s1Bb) (split
                            (5 -> (withdraw "A")))
                          )
   )
  (after 15 (reveal (s3Ad b) (split
                               (2 -> (withdraw "B"))
                               (2 -> (withdraw "A"))
                               (2 -> (withdraw "B")))
                             )
   )
  (after 15 (reveal (s3Bd b) (split
                               (2 -> (withdraw "B"))
                               (2 -> (withdraw "A"))
                               (2 -> (withdraw "B")))
                             )
   )
  (after 15 (after 20 (reveal (s3Ab) (split
                                       (5 -> (withdraw "B")))
                                     )
             )
   )
  (after 15 (after 20 (reveal (s3Bb) (split
                                       (5 -> (withdraw "A")))
                                     )
             )
   )
  (after 15 (after 30 (split
                        (3 -> (split
                                (1 -> (withdraw "A"))
                                (1 -> (withdraw "A"))
                                (1 -> (withdraw "B")))
                        )
                        (3 -> (split
                                (1 -> (withdraw "B"))
                                (1 -> (withdraw "A"))
                                (1 -> (withdraw "B")))
                        ))
             )
   )
  ))
