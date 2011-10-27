module Main where


import GF.Predictability
import GF.Predictability.Utils

-- *********************************** VERBS *********************************
testVerb :: TestFunction
testVerb [ går,gås,gick,gicks,
           gå_imp,_,gå_inf,gås_inf,gått,gåtts,
           gången,gångens,gånget,gångets,
           gångna_undef,gångnas_undef,gångna_def,gångnas_def, 
           _,_,_,_ ] lex =
  zip [ går,gås,gick,gicks,
        gå_imp,gå_inf,gås_inf,gått,gåtts,
        gången,gångens,gånget,gångets,
        gångna_undef,gångnas_undef,gångna_def,gångnas_def ] lex
testVerb _ _ = undefined

setupVerb :: SetupFunction
setupVerb fs | "" `elem` fs = skip $ "Missing form"
setupVerb [ går,gås,gick,gicks,
            gå_imp,gå_inf,gås_inf,gått,gåtts,
            gången,gångens,gånget,gångets,
            gångna_undef,gångnas_undef,gångna_def,gångnas_def ] =
  return [ [ esc gå_inf ]
         , [ esc gå_inf, esc gick, esc gått ]
         , [ esc gå_inf, esc går, esc gå_imp, esc gick, esc gått, esc gången ] ]
setupVerb o = skip $ "Invalid lexicon entry"

  
main :: IO ()
main = do
  let verbEx = mkExperimentWithFunctions 
               "Swedish verbs (with infinitive)"
               "alltenses/ParadigmsSwe.gfo"
               "mkV"
               setupVerb
               testVerb
  mainRunExperiment verbEx
