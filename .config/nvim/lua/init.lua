-- Bootstrapping
local pluginman_opt = true
local pluginman_repo = 'https://github.com/wbthomason/packer.nvim'
local print_err = vim.api_err_writeln

-- Do not source default filetype.vim
vim.g.did_load_filetypes = 1

local bootstrap = function()
    local execute = vim.api.nvim_command
    local fn = vim.fn

    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if pluginman_opt then
        install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
    end

    if fn.empty(fn.glob(install_path)) > 0 then
        print("packer.nvim not found in " .. install_path .. ", try install ...")
        fn.system { "git", "clone", pluginman_repo, install_path }
        if pluginman_opt then
            execute "packadd packer.nvim"
        end
        print("packer.nvim installed to " .. install_path)
    end
end

bootstrap()

if pluginman_opt then
    vim.cmd [[packadd packer.nvim]]
end

-- Load modules
require("options")
require("plugins")
