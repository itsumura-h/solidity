// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/draft-IERC6093.sol

interface IERC20Errors {
  /**
   * @dev 転送時に使用される、`sender`の現在の`balance`に関連するエラーを示します。
   * @param sender トークンが転送されるアドレス。
   * @param balance 対話中のアカウントの現在の残高。
   * @param needed 転送を実行するために必要な最小金額。
   */
  error ERC20InsufficientBalance(
    address sender,
    uint256 balance,
    uint256 needed
  );

  /**
   * @dev トークンの`sender`に関連する失敗を示します。転送時に使用されます。
   * @param sender トークンが転送されるアドレス。
   */
  error ERC20InvalidSender(address sender);

  /**
   * @dev トークンの`receiver`に関連する失敗を示します。転送時に使用されます。
   * @param receiver トークンが転送されるアドレス。
   */
  error ERC20InvalidReceiver(address receiver);

  /**
   * @dev `spender`の`allowance`に関連する失敗を示します。転送時に使用されます。
   * @param spender トークンの所有者ではなくても、トークンを操作することを許可されるアドレス。
   * @param allowance `spender`が操作を許可されているトークンの量。
   * @param needed 転送を実行するために必要な最小金額。
   */
  error ERC20InsufficientAllowance(
    address spender,
    uint256 allowance,
    uint256 needed
  );

  /**
   * @dev 承認されるトークンの`approver`に関連する失敗を示します。承認時に使用されます。
   * @param approver 承認操作を開始するアドレス。
   */
  error ERC20InvalidApprover(address approver);

  /**
   * @dev 承認される`spender`に関連する失敗を示します。承認時に使用されます。
   * @param spender トークンの所有者ではなくても、トークンを操作することを許可されるアドレス。
   */
  error ERC20InvalidSpender(address spender);
}
