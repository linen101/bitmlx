module Pretty where

import Syntax 

import Prettyprinter.Internal
import Prettyprinter.Internal.Type
import Prettyprinter.Symbols.Ascii

import Prettyprinter.Util

{-
prettyprintType :: [Doc x] -> Doc x
prettyprintType = align . sep . zipWith (<+>) ( repeat (pretty "->"))

prettyprintDeclaration :: Pretty a => a -> [Doc b] -> Doc b
prettyprintDeclaration n tys1  = pretty n <+> prettyprintType  tys1
-}

prettypred :: Pred -> Doc x
prettypred PTrue        = pretty "true"
prettypred (Pand p1 p2) = parens ( pretty "pred" <+> parens ( pretty "and" <+> prettypred p1 <+> prettypred p2 ))
prettypred (Pnot p)     = parens ( pretty "pred" <+> parens ( pretty "not" <+> prettypred p ))
prettypred (Peq e1 e2)  = parens ( pretty  "=" <+> prettyexp e1 <+> prettyexp e2 )
prettypred (Plt e1 e2)  = emptyDoc

prettyexp :: E -> Doc x
prettyexp (Eint n)      = pretty n
prettyexp (Elength s)   = pretty s   -- length of a secret
prettyexp (Eadd e1 e2)  = parens ( pretty "+" <+> prettyexp e1 <+> prettyexp e2)
prettyexp (Esub e1 e2)  = parens ( pretty "-" <+> prettyexp e1 <+> prettyexp e2)

prettyprintSplit :: [Doc a] -> [Doc a] -> Doc a
prettyprintSplit xs cs =  align ( pretty "split" <> line)  <+> ( align $ sep $ zipWith ( \x y -> parens (x <+> (pretty "->") <+> y) ) xs cs)
                         

prettyprint :: C -> Doc x
prettyprint []                          = emptyDoc
prettyprint (Withdraw p : cs)           = parens ( align ( pretty "withdraw" <+> dquotes (pretty p) ) ) <> align (prettyprint cs ) -- <> line
prettyprint (Split xs cs : cs')         = parens ( prettyprintSplit (map pretty xs) (map prettyprintNew cs) ) <> line <> align  (prettyprint cs')  -- <> line
prettyprint (Auth p d : cs)             = parens ( align (pretty "auth" <+> dquotes (pretty p) <+> prettyprint [d] ) ) <> line <>  align (prettyprint cs ) -- <> line
prettyprint (After t d : cs)            = parens ( align (pretty "after" <+> pretty t <+> prettyprint [d]) ) <> line <> align (prettyprint cs )
prettyprint (Reveal as cs : cs')        = parens ( align (pretty "reveal" <+> parens (hsep (map pretty as) ) <+> align ( prettyprintNew cs) ) ) <> line <> align (prettyprint cs' )
prettyprint (Put xs cs : cs')           = parens ( align (pretty "put" <+> hsep (map pretty xs) <+> prettyprintNew cs ) ) <> line <> align (prettyprint cs' )
prettyprint (Revealif as pred cs : cs') = parens ( align (pretty "revealif" <+> parens (hsep (map pretty as)) <+> prettypred pred <+> prettyprintNew cs ) ) <> line <> align (prettyprint cs' )

prettyprintNew :: C -> Doc x
prettyprintNew []   = emptyDoc
prettyprintNew [c]  = prettyprint [c]
prettyprintNew c    = parens $ pretty "choice" <> line <+> align (prettyprint c)


prettyprintG :: Gl -> Doc x
prettyprintG                      [] = emptyDoc
prettyprintG (Dep p v tx : gs)       = parens ( align (pretty "deposit" <+> dquotes (pretty p) <+> (pretty v) <+> dquotes (pretty tx) ) ) <> line <> align (prettyprintG gs)
prettyprintG (VolDep p v x tx : gs)  = parens ( align (pretty "vol-deposit" <+> dquotes (pretty p) <+> (pretty x ) <+> (pretty v) <+> dquotes (pretty tx) ) ) <> line <> align (prettyprintG gs)
prettyprintG (Secret p s shash : gs) = parens ( align (pretty "secret"<+> dquotes (pretty p) <+> (pretty s) <+> dquotes (pretty shash) ) ) <> line <> align (prettyprintG gs)

prettyprintGNew :: Gl -> Doc x
prettyprintGNew [] = emptyDoc
prettyprintGNew g  = parens $ pretty "pre" <> line <+> align (prettyprintG g)

prettyprintP :: Pl -> Doc x
prettyprintP              [] = emptyDoc
prettyprintP (Par p pk : ps) = parens (align (pretty "participant" <+> dquotes (pretty p) <+> dquotes (pretty pk) ) ) <> line <> align (prettyprintP ps)

prettyprintGC :: Gl -> C -> Doc x
prettyprintGC g c = parens ( pretty "contract" <> line <+> align ( prettyprintGNew g ) <> line <> line <+> align ( prettyprintNew c )) <> line

prettyprintNL :: Pl -> Gl -> C -> Doc x
prettyprintNL p g c = prettyprintP p <> line <> prettyprintGC g c