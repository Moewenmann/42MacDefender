# 42MacDefender

At 42, leaving your seat without locking your screen can lead to unexpected surprises upon your return. Enter MacDefender:

42MacDefender is a simple tool that is called up every time a terminal is started and cannot be closed until a pre-set password is entered, thus preventing input into the terminal.

It's important to note that MacDefender doesn't guarantee absolute protection against unauthorized access. Someone who has unrestricted access to your PC will be able to change settings, steal data or install software despite this tool. While MacDefender adds an extra layer of security, it's not foolproof. Think of it as a temporary deterrent rather than a fail-safe solution.

**Install:**
```
chmod +x install.sh
```
```
./install.sh
```

**Customization:**
The default password is "42" but you can personalize it by editing the `.zshrc` file.

To generate a new password, use the following command and replace `MDFPASS="{replace}"` in `.zshrc` with the output:
```
printf "{Custom Password}" | shasum
```

**Usage:**
- To toggle MacDefender on or off, use:
```
lock toggle
```
- To lock the terminal manually, simply enter:
```
lock
```
