﻿// Copyright (c) 2018 FiiiLab Technology Ltd
// Distributed under the MIT software license, see the accompanying
// file LICENSE or http://www.opensource.org/licenses/mit-license.php.
using FiiiChain.Framework;
using System;

namespace FiiiChain.Node
{
    class Program
    {
        static void Main(string[] args)
        {
            bool testnet = false;

            if (args.Length == 1 && args[0].ToLower() == "-testnet")
            {
                testnet = true;
                LogHelper.Info("FiiiChain Testnet Engine is Started.");
            }
            else
            {
                LogHelper.Info("FiiiChain Engine is Started.");
            }

            try
            {
                GlobalParameters.IsTestnet = testnet;
                BlockchainJob.Initialize();
                BlockchainJob.Current.Start();
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex.Message, ex);
            }

            //LogHelper.Debug("Press Enter to close");
            //Console.ReadLine();

            //BlockchainJob.Current.Stop();
        }
    }
}
