#!/bin/bash

if [  ! `cat replit.nix | grep yarn` ]; then
curl -s -L https://raw.githubusercontent.com/jbwfu/YesPlayMusic-Replit/main/.replit -o .replit
curl -s -L https://raw.githubusercontent.com/jbwfu/YesPlayMusic-Replit/main/replit.nix -o replit.nix
echo 初始化 replit.nix... 请再次运行此命令
exit
fi

echo 构建过程中若失败请再次运行此命令
sleep 1

if [ ! -d "api" ]; then
git clone https://github.com/Binaryify/NeteaseCloudMusicApi.git api
fi

if [ ! -d "music" ]; then
git clone https://github.com/qier222/YesPlayMusic.git music
cp ./music/.env.example ./music/.env
fi


cd api && npm install
cd ../music && yarn install && yarn run build && cd ..

curl -s -L https://raw.githubusercontent.com/jbwfu/YesPlayMusic-Replit/main/main.sh -o main.sh

bash main.sh