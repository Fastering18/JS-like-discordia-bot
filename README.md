# JS-like-discordia-bot
An example to implement JavaScript function in luvit with discordia  

This source is used by [Scanner 5](https://discord.com/users/846401560652546078) as website staff bot  

## Get started  
Make sure to downloaded all **[luvit](https://luvit.io/install.html)** binaries  
Install [discordia](https://github.com/SinisterRectus/Discordia) using following command
```bash
lit install SinisterRectus/discordia
```
> make sure `lit` command installed from luvit.io  

### Run your bot  
Add environment variable `BotToken` containing your bot token  
Run following command
```bash
luvit main.lua
```
![Ouputs](https://i.gyazo.com/2608629c6b1a3c33a55355df03c80a3a.png)  

## Host discord bot  
### replit.com  
Visit website [here](https://replit.com)  
Register an account and create new repl  
Run following bash command to install luvit
```bash
git clone --recursive https://github.com/luvit/lit.git lit-src
./build/luvi lit-src -- make lit-src
```  
> binaries installed will be in repl root folder, you can run it using `./luvit [any]`
> adding to PATH require root permission, run manually instead  

Run discord bot
```bash
luvit main.lua
```
