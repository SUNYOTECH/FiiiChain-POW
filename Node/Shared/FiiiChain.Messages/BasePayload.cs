﻿using System;
using System.Collections.Generic;
using System.Text;

namespace FiiiChain.Messages
{
    [Serializable]
    public abstract class BasePayload
    {
        public abstract byte[] Serialize();

        public abstract void Deserialize(byte[] bytes, ref int index);
    }
}
