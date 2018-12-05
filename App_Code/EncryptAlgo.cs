using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;
/// <summary>
/// Summary description for EncryptAlgo
/// </summary>
public class EncryptAlgo
{
    public EncryptAlgo()
    { }

    public const string theKey = "oRJUjgbx9SGGR6v3T8JGJg==";
    public const string theIV = "f+hYUyjprHt/6FhTKOmsew==";

    public static String EncryptText(String Data, String Key, String IV)
    {
        // Extract the bytes of each of the values
        byte[] input = Encoding.UTF8.GetBytes(Data);
        byte[] key = Convert.FromBase64String(Key);
        byte[] iv = Convert.FromBase64String(IV);

        // Create a new instance of the algorithm with the desired settings
        RijndaelManaged algorithm = new RijndaelManaged();
        algorithm.Mode = CipherMode.CBC;
        algorithm.Padding = PaddingMode.PKCS7;
        algorithm.BlockSize = 128;
        algorithm.KeySize = 128;
        algorithm.Key = key;
        algorithm.IV = iv;

        // Create a new encryptor and encrypt the given value
        ICryptoTransform cipher = algorithm.CreateEncryptor();
        byte[] output = cipher.TransformFinalBlock(input, 0, input.Length);

        // Finally, return the encrypted value in base64 format
        String encrypted = Convert.ToBase64String(output);

        return encrypted;
    }

    public static String DecryptText(String Data, String Key, String IV)
    {
        // Extract the bytes of each of the values
        byte[] input = Convert.FromBase64String(Data.Replace(" ", "+"));
        byte[] key = Convert.FromBase64String(Key);
        byte[] iv = Convert.FromBase64String(IV);


        // Create a new instance of the algorithm with the desired settings
        RijndaelManaged algorithm = new RijndaelManaged();
        algorithm.Mode = CipherMode.CBC;
        algorithm.Padding = PaddingMode.PKCS7;
        algorithm.BlockSize = 128;
        algorithm.KeySize = 128;
        algorithm.Key = key;
        algorithm.IV = iv;

        //FromBase64String
        // Create a new encryptor and encrypt the given value
        ICryptoTransform cipher = algorithm.CreateDecryptor();
        byte[] output = cipher.TransformFinalBlock(input, 0, input.Length);

        // Finally, convert the decrypted value to UTF8 format
        String decrypted = Encoding.UTF8.GetString(output);

        return decrypted;
    }
}