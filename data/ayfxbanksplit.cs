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

    public static int Main(string[] args)
    {
        if (args.Length < 1)
        {
            return ConsoleError("Usage: ayfxbanksplit <bank file>", 1);
        }

        var inputFile = args[0];
        if (!File.Exists(inputFile))
        {
            return ConsoleError("Specified file could not be opened.", 2);
        }

        var bytes = File.ReadAllBytes(inputFile);
        var count = bytes[0];
        var offsets = new int[count+1];
        for (int i = 0; i < 2 * count; i += 2) {
            offsets[i / 2] = 2 + i + bytes[i+1] + (bytes[i+2] * 256);
        }
        offsets[count] = bytes.Length;

        for (int i = 0; i < count; ++i) {
            int o = offsets[i];
            int l = offsets[i+1] - o;
            File.WriteAllBytes($"{i+1}.afx", bytes.Skip(o).Take(l).ToArray());
        }

        return 0;
    }
}
