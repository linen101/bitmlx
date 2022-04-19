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
  (secret "A" s1Ad "001Ad")
  (deposit "B" 1 "y1")
  (deposit "B" 2 "y1col")
  (secret "B" s1Bb "001Bb")
  (secret "B" s1Bd "001Bd")
  )

 (choice
  (after 1 (reveal (dummy) (choice
                            (after 2 (reveal (dummy) )
                             )
                            (reveal (s1Ad) (split
                                             (5 -> (withdraw "B")))
                                           )
                            (reveal (s1Bd) (split
                                             (5 -> (withdraw "A")))
                                           )
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
