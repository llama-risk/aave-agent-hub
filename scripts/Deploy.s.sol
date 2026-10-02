// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {WithChainIdValidation} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {DeployAgentHub} from './AgentHub.s.sol';
import {DeployRangeValidationModule} from './RangeValidationModule.s.sol';

// Monad addresses from aave-address-book (MiscMonad, GovernanceV3Monad)
library MonadAddresses {
  uint256 internal constant CHAIN_ID = 143;
  address internal constant TRANSPARENT_PROXY_FACTORY = 0x2f09b9D890535c2b5c81b1b95F7f92eeed5B9d5D;
  address internal constant EXECUTOR_LVL_1 = 0xa9d0EAFF48cE1DF468f9eAeb7e628c413343F6A2;
}

// make deploy-ledger contract=scripts/Deploy.s.sol:DeployMonad chain=monad
contract DeployMonad is WithChainIdValidation {
  constructor() WithChainIdValidation(MonadAddresses.CHAIN_ID) {}

  function run() external broadcast {
    DeployAgentHub._deployAgentHub(
      MonadAddresses.TRANSPARENT_PROXY_FACTORY,
      MonadAddresses.EXECUTOR_LVL_1,
      MonadAddresses.EXECUTOR_LVL_1
    );
    DeployRangeValidationModule._deployRangeValidationModule();
  }
}
