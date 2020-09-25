module Example exposing (suite)

import Expect
import Test exposing (Test, test)


suite : Test
suite =
    test "sanity" <|
        \_ ->
            List.isEmpty []
                |> Expect.true "expected list to be empty"
