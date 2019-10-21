using System;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Text;

public class SoundBankSplitter
{
    private static void ConsoleWriteColour(ConsoleColor colour, string message)
    {
        var cachedColour = Console.ForegroundColor;
        Console.ForegroundColor = colour;
        Console.WriteLine(message);
        Console.ForegroundColor = cachedColour;
    }

    private static void ConsoleWarn(string warning)
    {
        ConsoleWriteColour(ConsoleColor.DarkYellow, warning);
    }

    private static int ConsoleError(string error, int errorNumber)
    {
        ConsoleWriteColour(ConsoleColor.Red, error);
        return errorNumber;
    }

    public static void opAdd(List<byte> output, int op) {
        output.Add((byte)op);
        //Console.Write($" {op:X2}");
    }

    public static int Main(string[] args)
    {
        var output = new List<byte>();

        if (args.Length < 1)
        {
            return ConsoleError("Usage: fxdecode <fx file>", 1);
        }

        var inputFile = args[0];
        if (!File.Exists(inputFile))
        {
            return ConsoleError("Specified file could not be opened.", 2);
        }

        var outfileName = Path.ChangeExtension(inputFile, "smfx");

        var bytes = File.ReadAllBytes(inputFile);
        var i = 0;
        while(i < bytes.Length && !(bytes[i] == 0xd0 && bytes[i+1] == 0x20)) {
            var newCtl = 0;

            var f = bytes[i];

            var tone = (f & 0x20) != 0;
            var noise = (f & 0x40) != 0;
            var tVal = 0;
            var nVal = 0;
            var vol = f & 15;

            newCtl = 15 - vol;

            Console.Write($"Vol: {vol} ");
            i ++;
            if (tone) {
                tVal = bytes[i] + bytes[i+1] * 256;
                newCtl |= 0x80;
                Console.Write($"Tone: {tVal} ");
                i+= 2;
            }
            if (noise) {
                nVal = bytes[i] & 15;
                if (nVal != 0) newCtl |= 0x40;
                Console.Write($"Noise: {nVal} ");
                ++i;
            }

            opAdd(output, newCtl);

            if (tone){
                var tLo = tVal & 15;
                var tHi = (tVal >> 4) & 0x3f;

                opAdd(output, tLo);
                opAdd(output, tHi);
            }
            if (noise){
                if (nVal > 7) nVal = 2;
                else if (nVal > 1) nVal = 1;

                opAdd(output, nVal);
            }
            Console.WriteLine("");
        }
        opAdd(output, 0x3f);
        File.WriteAllBytes(outfileName, output.ToArray());
        return 0;
    }
}
