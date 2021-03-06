﻿using FiiiCoin.Wallet.Win.Biz.Services;
using FiiiCoin.Wallet.Win.Common;
using FiiiCoin.Wallet.Win.Common.interfaces;
using FiiiCoin.Wallet.Win.Models;
using GalaSoft.MvvmLight.Messaging;
using Microsoft.Win32;
using System;
using System.ComponentModel.Composition;
using System.Threading.Tasks;

namespace FiiiCoin.Wallet.Win.Biz.Invokes
{
    [Export(typeof(IInvoke))]
    public class ExportBackInvoke : VmBase , IInvoke
    {
        public string GetInvokeName()
        {
            return InvokeKeys.BackUp;
        }

        public void Invoke<T>(T obj)
        {
            var result = CheckAndInputPwd();
            if (result)
            {
                Export();
            }
        }


        private bool CheckAndInputPwd()
        {
            var settingResult = FiiiCoinService.Default.GetTxSettings();
            if (settingResult.IsFail)
                return false;

            if (!settingResult.Value.Encrypt)
                return true;

            SendMsgData<InputWalletPwdPageTopic> data = new SendMsgData<InputWalletPwdPageTopic>();
            data.Token = InputWalletPwdPageTopic.UnLockWallet;
            data.SetCallBack(()=>
            {
                Export(true);
                OnClosePopup();
            });
            SendMessenger(Pages.InputWalletPwdPage, SendMessageTopic.Refresh);
            SendMessenger(Pages.InputWalletPwdPage, data);
            UpdatePage(Pages.InputWalletPwdPage);
            return false;
        }

        void Export(bool isEncrypt = false)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            var filter = isEncrypt ? "fcdatx（*.fcdatx）|*.fcdatx" : "fcdat（*.fcdat）|*.fcdat";
            saveFileDialog.Filter = filter;
            saveFileDialog.RestoreDirectory = true;
            var result = saveFileDialog.ShowDialog(BootStrapService.Default.Shell.GetWindow());
            if (result.HasValue && result.Value)
            {
                var file = saveFileDialog.FileName;
                var exportResult = WalletService.Default.ExportBackupWallet(file);
                if (!exportResult.IsFail)
                    ShowMessage(LanguageService.Default.GetLanguageValue(MessageKeys.Backup_Sucesses));
                else
                    ShowMessage(LanguageService.Default.GetLanguageValue(MessageKeys.Backup_Fail));
            }

            if (isEncrypt)
                WalletService.Default.LockWallet();
        }
    }

    

}
