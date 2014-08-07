using System;
using System.Collections;
using System.Resources;

/// Build via 'mcs DumpResources.cs'
public class DumpResources
{
   public static void Main()
   {
        ResourceReader rdr = new ResourceReader("Example.resources");
        Console.WriteLine(rdr.GetType());
        IDictionaryEnumerator dict = rdr.GetEnumerator();
        while (dict.MoveNext()) {
            Console.WriteLine("{0}: '{1}' (Type {2})",
                dict.Key, dict.Value, dict.Value.GetType().Name);
        }
        rdr.Close();
   }
}
