#!/bin/sh
cd
mkdir -p ~/git

# required utilities
sudo apt install -y pkg-config libncursew5-dev libreadline6-dev build-essentials autogen auto-make

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nnn
cd ~/git && git clone https://github.com/jarun/nnn
cd nnn
make
sudo make strip install
cd

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ripgrep 
sudo apt-get install ripgrep -y

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#powerlevel10k & purepower
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower

echo "Reminder for universal ctags: https://github.com/universal-ctags/ctags see ctags.sh"

echo "git clone https://github.com/universal-ctags/ctags ~/git/ctags \
	cd ~/git/ctags \
	./autogen.sh \
	./configure \
	make \
	sudo make install" > ctags.sh

#make links
echo "Making links"
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim/
ln -sf ~/.dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

echo "done"
