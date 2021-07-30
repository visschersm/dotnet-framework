using System;
using System.IO;

namespace ClassLibrary1
{
    public static class ConsoleUtils
    {
        public static void PrintStringWithColor(string input, ConsoleColor color)
        {
            var tempColor = Console.ForegroundColor;
            Console.ForegroundColor = color;
            Console.WriteLine(input);
            Console.ForegroundColor = tempColor;
        }

        public static void PrintStringWithRandomColor(string input)
        {
            var reader = new StringReader(input);
            var random = new Random();
            var index = random.Next(10) + 2;

            string line;
            while ((line = reader.ReadLine()) != null)
            {
                index = (index % 14) + 2;
                var color = (ConsoleColor)index++;
                PrintStringWithColor(line, color);
            }
        }
    }
}