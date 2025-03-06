-- Support for remote containers and ssh connections
-- https://github.com/amitds1997/remote-nvim

return {
    "amitds1997/remote-nvim.nvim",
    cmd = {
        "RemoteLog",
        "RemoteInfo",
        "RemoteStop",
        "RemoteStart",
        "RemoteCleanup",
        "RemoteConfigDel",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        ssh_config = {
            scp_binary = "rsync --perms --chmod=u+rwx,g+rwx,o+rwx",
        },
        offline_mode = {
            -- enabled = true,
        },
    },
}
