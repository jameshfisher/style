{-# LANGUAGE FlexibleInstances #-}

import Data.List (intersperse)

type Url = String

data CSS = CSS [Rule]

data Rule =
    Rule [Selector] [Declaration]
  | Import Url
  | Media Media CSS

data Media = Screen | Print

data Selector =
    Selector Element (Maybe PseudoClass)
  | Page

data Element =
    Tag String
  | Class String
data PseudoClass = Hover

data Declaration =
    Color Color
  | BackgroundColor Color
  | FontSize Size
  | Display Display
  | Margin Measurements
  | FontFamily [Font]
  | TextRendering TextRendering

type Font = String

data TextRendering = OptimizeLegibility

data Measurements =
    Measure4 Size Size Size Size
  | Measure2 Size Size
  | Measure1 Size

data Size =
    Zero
  | Pt Float
  | Cm Float
  | Px Float

data Color =
    BuiltinColor BuiltinColor
  | RGB Int Int Int

data Display = None

data BuiltinColor = Red

escape s = "\"" ++ (concat $ map escape' s) ++ "\""  where
  escape' '"' = "\\\""
  escape' c = [c]

instance Show CSS where show (CSS rs) = concat $ intersperse "\n" $ map show rs
instance Show Rule where
  show r = case r of
    Rule ss ds -> (concat $ intersperse "," $ map show ss) ++ "{" ++ (concat $ intersperse ";" $ map show ds) ++ "}"
    Import u -> "@import " ++ (escape u) ++ ";"
    Media m c -> "@media " ++ (show m) ++ "{\n" ++ (show c) ++ "\n}\n"
instance Show Media where show m = case m of { Screen -> "screen"; Print -> "print"; }
instance Show Selector where
  show s = case s of
    Selector e p -> (show e) ++ (case p of { Nothing -> ""; Just p' -> ":" ++ (show p') } )
    Page -> "@page"
instance Show Element where
  show e = case e of
    Tag t -> t
    Class c -> "." ++ c
instance Show PseudoClass where
  show p = case p of
    Hover -> "hover"
instance Show Declaration where
  show d = property ++ ":" ++ value where
    (property, value) = case d of
      Color c -> ("color", show c)
      BackgroundColor c -> ("background-color", show c)
      FontSize s -> ("font-size", show s)
      Display d -> ("display", show d)
      Margin m -> ("margin", show m)
      FontFamily fonts -> ("font-family", concat $ intersperse "," $ map escape fonts)
      TextRendering t -> ("text-rendering", show t)
instance Show TextRendering where
  show t = case t of
    OptimizeLegibility -> "optimizeLegibility"
instance Show Size where
  show s = case s of
    Zero -> "0"
    Pt n -> (show n) ++ "pt"
    Cm n -> (show n) ++ "cm"
    Px n -> (show n) ++ "px"
instance Show Color where
  show c = case c of
    BuiltinColor c' -> show c'
    RGB r g b -> "rgb(" ++ (concat $ intersperse "," $ map show $ [r,g,b]) ++ ")"
instance Show Measurements where
  show m = unwords $ map show $ case m of
    Measure4 a b c d -> [a,b,c,d]
    Measure2 a b -> [a,b]
    Measure1 a -> [a]
instance Show Display where show d = case d of { None -> "none" }
instance Show BuiltinColor where
  show c = case c of
    Red -> "red"

test = CSS
  [ Import "./funcs.css"
  , Import "./reset.css"
  , Import "http://fonts.googleapis.com/css?family=Crimson+Text&v2"
  , Media Print $ CSS
    [ Rule [Selector (Tag "body") Nothing] [FontSize $ Pt 10.5]
    , Rule [Selector (Class "screen") Nothing] [Display None]
    , Rule [Page] [Margin $ Measure4 (Cm 2) (Cm 2) (Cm 0) (Cm 2)]
    ]
  , Media Screen $ CSS
    [ Rule [Selector (Tag "body") Nothing] [FontSize $ Px 16]
    , Rule [Selector (Class "print") Nothing] [Display None]
    ]
  , Rule [Selector (Tag "body") Nothing]
    [ Margin $ Measure1 Zero
    , FontFamily ["Minion Pro", "Crimson"]
    , TextRendering OptimizeLegibility
    ]
  ]