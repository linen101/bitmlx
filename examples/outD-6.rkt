#lang bitml

(debug-mode)

(participant "A" "txA")
(participant "B" "txB")

(contract
 (pre
  (deposit "A" 1 "x1")
  (deposit "A" 2 "x1col")
  (secret "B" b "bbb")
  (secret "A" s1Ab "001Ab")
  (secret "A" s2Ab "002Ab")
  (secret "A" s1Ad "001Ad")
  (secret "A" s2Ad "002Ad")
  (deposit "B" 1 "y1")
  (deposit "B" 2 "y1col")
  (secret "B" s1Bb "001Bb")
  (secret "B" s2Bb "002Bb")
  (secret "B" s1Bd "001Bd")
  (secret "B" s2Bd "002Bd")
  )

 (choice
  (after 3 (reveal (dummy) (choice
                            (after 5 (reveal (dummy) (choice
                                                      (after 6 (reveal (dummy) )
                                                       )
                                                      (reveal (s2Ad) (split
                                                                       (5 -> (withdraw "B")))
                                                                     )
                                                      (reveal (s2Bd) (split
                                                                       (5 -> (withdraw "A")))
                                                                     )
                                                      (reveal (s1Ad) (split
                                                                       (5 -> (withdraw "B")))
                                                                     )
                                                      (reveal (s1Bd) (split
                                                                       (5 -> (withdraw "A")))
                                                                     )
                                                      ))
                             )
                            (reveal (s2Ab) (choice
                                            (after 4 (split
                                                       (2 -> (withdraw "B"))
                                                       (2 -> (withdraw "A"))
                                                       (2 -> (withdraw "B")))
                                             )
                                            (reveal (s1Ad) (split
                                                             (5 -> (withdraw "B")))
                                                           )
                                            (reveal (s1Bd) (split
                                                             (5 -> (withdraw "A")))
                                                           )
                                            ))
                            (reveal (s2Bb) (choice
                                            (after 4 (split
                                                       (2 -> (withdraw "B"))
                                                       (2 -> (withdraw "A"))
                                                       (2 -> (withdraw "B")))
                                             )
                                            (reveal (s1Ad) (split
                                                             (5 -> (withdraw "B")))
                                                           )
                                            (reveal (s1Bd) (split
                                                             (5 -> (withdraw "A")))
                                                           )
                                            ))
                            ))
   )
  (reveal (s1Ab) (after 0 (split
                            (2 -> (withdraw "A"))
                            (2 -> (withdraw "A"))
                            (2 -> (withdraw "B")))
                  )
                 )
  (reveal (s1Bb) (after 0 (split
                            (2 -> (withdraw "A"))
                            (2 -> (withdraw "A"))
                            (2 -> (withdraw "B")))
                  )
                 )
  ))
