// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {WithChainIdValidation} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {DeployAgentHub} from './AgentHub.s.sol';
import {DeployRangeValidationModule} from './RangeValidationModule.s.sol';

// X Layer addresses from aave-address-book (MiscXLayer, GovernanceV3XLayer)
library XLayerAddresses {
  uint256 internal constant CHAIN_ID = 196;
  address internal constant TRANSPARENT_PROXY_FACTORY = 0xF6Dac650dA5616Bc3206e969D7868e7c25805171;
  address internal constant EXECUTOR_LVL_1 = 0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19;
}

// make deploy-ledger contract=scripts/Deploy.s.sol:DeployXLayer chain=xlayer
contract DeployXLayer is WithChainIdValidation {
  constructor() WithChainIdValidation(XLayerAddresses.CHAIN_ID) {}

  function run() external broadcast {
    DeployAgentHub._deployAgentHub(
      XLayerAddresses.TRANSPARENT_PROXY_FACTORY,
      XLayerAddresses.EXECUTOR_LVL_1,
      XLayerAddresses.EXECUTOR_LVL_1
    );
    DeployRangeValidationModule._deployRangeValidationModule();
  }
}
