// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IRole} from "./functions/Role/IRole.sol";

interface Interface is IERC20, IRole {}
