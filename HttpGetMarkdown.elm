module Main (..) where

import Http
import Markdown
import Html exposing (Html)
import Task exposing (Task, andThen)


main : Signal Html
main =
    Signal.map Markdown.toHtml readme.signal



-- set up mailbox
--      the signal is piped directly to main
--      the address lets us update the signal


readme : Signal.Mailbox String
readme =
    Signal.mailbox ""



-- send some markdown to our readme mailbox


report : String -> Task x ()
report markdown =
    Signal.send readme.address markdown



-- get the readme *andThen* send the results to our mailbox


port fetchReadme : Task Http.Error ()
port fetchReadme =
    Http.getString readmeUrl `andThen` report


(=>) =
    (,)



-- the URL of the README.md that we desire


readmeUrl : String
readmeUrl =
    --the following causes:
    --XMLHttpRequest cannot load https://row.githubusercontent.com/elm-lang/core/master/README.md. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:8000' is therefore not allowed access. The response had HTTP status code 500
--     "https://row.githubusercontent.com/elm-lang/core/master/README.md"
    --try this instead - nope - elm reactor doesn't serve up this file
    --"http://localhost:8000/ElmArchitectureREADME.md"
    --setup Node server via http://stackoverflow.com/a/8427954
    "http://localhost:8080/README.md"
