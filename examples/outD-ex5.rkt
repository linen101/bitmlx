#lang bitml

(debug-mode)

(participant "A" "txA")
(participant "B" "txB")

(contract
 (pre
  (deposit "A" 1 "x1")
  (deposit "A" 1 "x1col")
  (secret "B" b "bbb")
  (secret "A" s1Ab "001Ab")
  (secret "A" s2Ab "002Ab")
  (secret "A" s1Ad "001Ad")
  (secret "A" s2Ad "002Ad")
  (deposit "B" 1 "y1col")
  (secret "B" s1Bb "001Bb")
  (secret "B" s2Bb "002Bb")
  (secret "B" s1Bd "001Bd")
  (secret "B" s2Bd "002Bd")
  )

 (choice
  (reveal (s1Ad b) (choice
                    (reveal (s2Ad) (split
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "B")))
                                   )
                    (reveal (s2Bd) (split
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "B")))
                                   )
                    (after 3 (reveal (s2Ab) (split
                                              )
                                            )
                     )
                    (after 3 (reveal (s2Bb) (split
                                              (3 -> (withdraw "A")))
                                            )
                     )
                    (after 13 (split
                                (1 -> (withdraw "B"))
                                (1 -> (withdraw "A"))
                                (1 -> (withdraw "B")))
                     )
                    ))
  (reveal (s1Bd b) (choice
                    (reveal (s2Ad) (split
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "B")))
                                   )
                    (reveal (s2Bd) (split
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "A"))
                                     (1 -> (withdraw "B")))
                                   )
                    (after 3 (reveal (s2Ab) (split
                                              )
                                            )
                     )
                    (after 3 (reveal (s2Bb) (split
                                              (3 -> (withdraw "A")))
                                            )
                     )
                    (after 13 (split
                                (1 -> (withdraw "B"))
                                (1 -> (withdraw "A"))
                                (1 -> (withdraw "B")))
                     )
                    ))
  (after 2 (reveal (s1Ab) (split
                            )
                          )
   )
  (after 2 (reveal (s1Bb) (split
                            (3 -> (withdraw "A")))
                          )
   )
  (after 12 (split
              (1 -> (withdraw "A")) (1 -> (withdraw "A")) (1 -> (withdraw "B")))
   )
  ))
