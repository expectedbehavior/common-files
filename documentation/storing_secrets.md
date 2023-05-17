If you'd like to store your personal, command-line secrets in a way that makes it easy to set up a new computer, consider storing them in an encrypted volume in Dropbox and mounting them on startup.

1. Open Disk Utility
2. Make a 'new image'. It's probably in the File menu.
3. Make a blank image named "secrets" and place it in the root of your Dropbox. I went with APFS, case-insensitive, 100mb, single GUID partition map. This image will immediately take up 100mb. Normally I'd recommend making something like this sparse so it only takes up the needed space, but I don't want anyone to be able to tell how much of the space is used until they've got access to it.
4. Make sure encryption is selected. I chose 128-bit AES. It will prompt you for a password as soon as you select an encryption type.
5. Once saved, it should be mounted at /Volumes/secrets. Make a blank folder in there, then unmount the volume.
6. Open the image to re-mount the encrypted volume. You can just double-click the file in finder, if you like.
7. It should ask you for the password and provide the option to store the password in your keychain. If you'd like seamless mounting on startup, make sure to add it to the keychain. It's not big deal if you don't, but it should be perfectly safe. By default, your keychain is encrypted using the same password you log in with.
8. Verify the folder you made it still there.
9. Open up the system preferences, accounts, then select login items and add an entry to open the disk image at login: just drag the disk image to the login items list. If you saved the disk image's password in the keychain, it won't ask you before it mounts it.
10. Reboot to verify it automatically mounted the image
11. Move your secrets `mv ~/.ssh /Volumes/secrets && mv ~/.aws /Volumes/secrets`
12. Symlink those secrets `ln -s /Volumes/secrets/.ssh ~/.ssh && ln -s /Volumes/secrets/.aws ~/.aws`
13. Verify you can still use your secrets
