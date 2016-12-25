# little-scripts

## Literally a little cache of little little-scripts!


These are little tools for everyday life.

*Requires standard Linux tools - python3, rsync, tar - to work, as a general rule!*

### General Tools:
-**linkPath**: Call with sudo; automatically links (or deletes a link with -d) an executable to /usr/local/bin, removing any extension.
-**syncGate**: Rsync through an ssh gateway using ssh agent forwarding. Call with gateway, target, target path, and optionally local path!

### **Requires gpg**
-**enc**: Pipe anything in, and it will encrypt it (as text) for given recipients and output on stdout.
* Pipe into `xclip -selection c` to automatically copy to clipboard!

-**decr**: Pipe encrypted data in (like from `xclip -o`), and it will check sigs & decrypt it to stdout.

### **Requires ffmpeg**

-**mled**: Simple H.264/mp4 processing, most notably removing/adding sound files (great when I render out a better mix for a finished film).

-**mlov**: Easily & *quickly* make an mp4 from an image sequence. More options for shallow quality control.

### **Requires djv-view**

-**sek**: The universal sequence viewer! Point sek at directories & videos alike - it'll open up djv-view to play it.
