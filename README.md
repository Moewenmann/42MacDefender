# 42MacDefender

At 42, leaving your seat without locking your screen can lead to unexpected surprises upon your return. Enter MacDefender:

42MacDefender is a simple tool that is called up every time a terminal is started and cannot be closed until a pre-set password is entered, thus preventing input into the terminal.

It's important to note that MacDefender doesn't guarantee absolute protection against unauthorized access. Someone who has unrestricted access to your PC will be able to change settings, steal data or install software despite this tool. While MacDefender adds an extra layer of security, it's not foolproof. Think of it as a temporary deterrent rather than a fail-safe solution.

**Install:**
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Moewenmann/42MacDefender/main/install.sh)"
```

**ConfigShield:**

Every time a terminal is started, ConfigShield is also executed.
ConfigShield searches for patterns from the `config.scanlist` in `.zshrc` and warns about matches or changes to the file.

**Customization:**

The default password is "42" but you can personalize it by editing the `.zshrc` file.
To generate a new password, use the following command and replace `MDFPASS="{replace}"` in `.zshrc` with the output:
```
printf "{Custom Password}" | shasum
```
You can adjust the behavior of the ConfigShield with the following variables in `configshield.sh`:
- `SHIELD_MODE`: Defines the mode of the script. Possible values are "remove", "ask", "warn" and "off".
- `SHIELD_RUN_NOTIFY`: If set to "true", the script notifies the user after a successful scan.

The `config.scanlist` file contains the list of signatures that the script searches for. The installer inserts a standard set of signatures.

**Usage:**
- To toggle MacDefender on or off, use:
```
lock toggle
```
- To lock the terminal manually, simply enter:
```
lock
```
