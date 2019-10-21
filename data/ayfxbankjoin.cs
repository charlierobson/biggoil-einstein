using System;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Text;

public class SoundBankJoiner
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

    public static int Main(string[] args)
    {
        if (args.Length < 1) {
            return ConsoleError("Usage: ayfxbankjoin <dest bank file>", 1);
        }

        var outputFile = args[0];
        if (File.Exists(outputFile)) {
            return ConsoleError("Specified output file already exists.", 2);
        }

        var afxes = new List<byte[]>();
        while (File.Exists($"{afxes.Count()}.afx")) {
            afxes.Add(File.ReadAllBytes($"{afxes.Count()}.afx"));
        }

        var fc = afxes.Count();
        var bc = afxes.Aggregate(0, (acc, x) => acc + x.Length);

        Console.WriteLine($"{fc} files found, {bc} bytes.");

        var afb = new byte[1 + 2 * fc + bc];

        afb[0] = (byte)fc;
        var afxbase = 1 + 2 * fc;
        for (int i = 0; i < fc; ++i) {
            var addr = i * 2 + 2;
            var msb = (afxbase - addr) / 256;
            var lsb = (afxbase - addr) % 256;
            afb[addr-1] = (byte)lsb;
            afb[addr] = (byte)msb;

            var afxlen = afxes[i].Length;
            Array.Copy(afxes[i], 0, afb, afxbase, afxlen);
            afxbase += afxlen;
        }

        File.WriteAllBytes(outputFile, afb);

        return 0;
    }
}
