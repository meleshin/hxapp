{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Bench where

import Import

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getBenchR :: Handler Html
getBenchR = do
    let text = "Hello World!!! Hello World!!! Hello World!!! Hello World!!! <b>Hello World!!!</b> Hello World!!!" :: Text
    defaultLayout $ do
        setTitle "Tratata site"
        $(widgetFile "bench")

