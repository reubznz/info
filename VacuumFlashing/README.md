# VACUUM FLASHING

## Links and info

[Valetudo](https://valetudo.cloud/pages/installation/dreame.html)

[Firmware Builder](https://builder.dontvacuum.me/_dreame_mc1808.html)

[Legacy Rooting Notes](https://gist.github.com/stek29/5c44244ae190f3757a785f432536c22a)

## Prerequisites

Retrieve the serial number located underneath the dust bin (PxxxxFXxxxxxxxxxxxKFx)

Build your firmware from the [Vacuum Firmware Builder](https://builder.dontvacuum.me/_dreame_mc1808.html)

 - Your voucher = leave default
 - Your Email = your valid email address
 - Tick "Let DustBuilder generate a SSH Keypair for you"
 - Device serial number = your device serial number
 - Tick "Prepackage valetudoo"

![dustbuilder](https://github.com/reubznz/info/assets/47412059/725408a1-4311-4f7a-a381-c4a10262ec1b)

When you receive the email to say the firmware is ready, click through to the firmware location, and copy the URL of the firmware file for use in Step 14 below

## Connecting, Rooting and Flashing the Vacuum

1. Pry the cover off the Vacuum

![pry](https://github.com/reubznz/info/assets/47412059/b7950005-1d1f-4336-bfec-0ed106b5a873)

2. Connect your UART to the vacuum. Remember UART-RX goes to Vacuum-TX, UART-TX goes to Vacuum-RX!

![UART](https://github.com/reubznz/info/assets/47412059/6f7f65ea-7f4b-47c7-8b7a-754f4e08e0c4)

3. Open putty, start a serial connection

![image](https://github.com/reubznz/info/assets/47412059/e15e3ac4-74fa-4bb5-bc05-89cd01c7d423)

4. Confirm that you see a console with MIOT information

5. Press and hold the 's' key on your keyboard while performing the next few steps

6. Take vacuum off charging dock and press and hold the POWER button for 3 seconds to turn the vacuum off

7. Press and hold the HOME button for at least 3 seconds and continue to hold

8. Press and hold the POWER button for at least 3 seconds

9. Release HOME and POWER when you see repeated 's' on your putty session

10. Release the 's' key

11. You should now be in the uboot shell

12. Run the following commands in the uboot shell:

```
setenv init /bin/sh
boot
```

13. When `# /` appears, run the following commands in the stage1 shell:

```
mount /tmp
mkdir /tmp/fakeetc
cp -R /etc/* /tmp/fakeetc
mount --bind /tmp/fakeetc /etc
echo >> /tmp/fakeetc/inittab
echo '::respawn:-/bin/sh' >> /tmp/fakeetc/inittab
exec init
```

14. When `# /` appears, run the following commands in the stage2 shell:

```
cd /tmp
wget --no-check-certificate https://builder.dontvacuum.me/jobs/uuidgoeshere/dreame.vacuum.mc1808_fw.tar.gz
tar -xzvf dreame.vacuum.mc1808_fw.tar.gz
./install.sh
```

The vacuum will now install the new firmware and automatically reboot

15. Browse to the IP of the vacuum and set up MQTT settings

![image](https://github.com/reubznz/info/assets/47412059/a5f60861-76b6-43be-813a-8ec64acf475d)


