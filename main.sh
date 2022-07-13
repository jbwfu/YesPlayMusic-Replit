#!/bin/bash

if [  ! `cat replit.nix | grep yarn` ]; then
echo -e "{ pkgs }: {
	\tdeps = with pkgs; [
		\t\tyarn
		\t\tnodejs-16_x
		\t\tnodePackages.typescript-language-server
	\t];
}" > replit.nix
echo 初始化 replit.nix 成功！请再次运行
exit
fi

if [ ! -d "api" ]; then
echo 正在 clone NeteaseCloudMusicApi 仓库至 api
git clone https://github.com/Binaryify/NeteaseCloudMusicApi.git api
fi

if [ ! -d "music" ]; then
echo 正在 clone YesPlayMusic 仓库至 music
git clone https://github.com/qier222/YesPlayMusic.git music
cp ./music/.env.example ./music/.env
fi


cd api && npm install; cd ../music && yarn install && yarn run build && cd ..; sed -i 's/^cd api && npm install/#&/' main.sh

cd api
node app.js &
cd ..
cd music 
npm run serve
