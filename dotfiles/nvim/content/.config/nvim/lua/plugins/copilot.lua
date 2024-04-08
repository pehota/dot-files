return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = { "zbirenbaum/copilot.lua" }, -- Or { "github/copilot.vim" }
		opts = {
			mode = "split", -- newbuffer or split, default: newbuffer
			show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			prompts = {
				Explain = "Explain how it works.",
				Review = "Review the following code and provide concise suggestions.",
				Tests = "Briefly explain how the selected code works, then generate unit tests.",
				Refactor = "Refactor the code to improve clarity and readability.",
			},
		},
		build = function()
			vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
		end,
		event = "VeryLazy",
		keys = {
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code", mode = "x" },
			{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests", mode = "x" },
			{ "<leader>ccv", ":CopilotChatVsplitVisual", mode = "x", desc = "CopilotChat - Open in vertical split" },
			{ "<leader>ccc", ":CopilotChatInPlace<cr>", mode = "x", desc = "CopilotChat - Run in-place code" },
			{ "<leader>ccc", ":CopilotChatInPlace<cr>", mode = "n", desc = "CopilotChat - Run in-place code" },
		},
	},

	{ import = "lazyvim.plugins.extras.coding.copilot" },
}
