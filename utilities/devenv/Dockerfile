# - - prep image - -
FROM alpine:latest AS prep
RUN apk add --no-cache git
WORKDIR /prep
RUN git clone https://github.com/notpratheek/vim-luna && \
    git clone https://github.com/preservim/nerdcommenter && \
    git clone https://github.com/ohmyzsh/ohmyzsh && \
    git clone https://github.com/zsh-users/zsh-autosuggestions
RUN mv ohmyzsh/themes/dpoggi.zsh-theme ./ && \
    rm -rf ohmyzsh/themes/* && \
    mv ./dpoggi.zsh-theme ohmyzsh/themes && \
    rm -rf ohmyzsh/plugins/* && \
    rm -rf ohmyzsh/.git && \
    cp -r zsh-autosuggestions ohmyzsh/custom/plugins/zsh-autosuggestions

# - - final image - -
FROM alpine:latest
RUN apk add --no-cache vim zsh

# Create a new user
RUN adduser -S -D --shell /bin/zsh prdx && echo "prdx:test" | chpasswd
USER prdx

# copy from host
COPY docker_vimrc /home/prdx/.vimrc
COPY docker_zshrc /home/prdx/.zshrc

# copy from prep image
COPY --from=prep /prep/vim-luna/colors/luna-term.vim \
                 /home/prdx/.vim/colors/luna-term.vim
COPY --from=prep /prep/nerdcommenter/plugin/NERD_commenter.vim \
                 /home/prdx/.vim/plugin/NERD_commenter.vim
COPY --from=prep /prep/ohmyzsh \
                 /home/prdx/.oh-my-zsh

CMD ["/bin/zsh"]
