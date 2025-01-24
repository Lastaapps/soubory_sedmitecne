-- Kommentary
-- Used for comments
-- github.com/b3nj5m1n/kommentary
-- gcc - Toggle line
-- gc  - Toggle selection/motion
return {
    'b3nj5m1n/kommentary',
    event = "InsertEnter",
    config = function()
        require('kommentary.config').configure_language(
            "default",
            { prefer_single_line_comments = true, }
        )
    end
}
