// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./ZombieFactory.sol";

interface KittyInterface {
  function getKitty(
    uint256 _id
  )
    external
    view
    returns (
      bool isGestating,
      bool isReady,
      uint256 cooldownIndex,
      uint256 nextActionAt,
      uint256 siringWithId,
      uint256 birthTime,
      uint256 matronId,
      uint256 sireId,
      uint256 generation,
      uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {
  // 外部コントラクトの呼び出し
  // KittyInterface kittyContract;

  modifier ownerOf(uint _zombieId) {
    require(zombieToOwner[_zombieId] == msg.sender);
    _;
  }

  function feedAndMultiply(
    uint _zombieId,
    uint _targetDna,
    string memory _species
  ) internal ownerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];

    require(_isReady(myZombie));

    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;

    if (keccak256(abi.encodePacked(_species)) == keccak256("kitty")) {
      newDna = newDna - (newDna % 100) + 99;
    }

    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  // function feedOnKitty(uint _zombieId, uint _kittyId) public {
  //     uint kittyDna;
  //     (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
  //     feedAndMultiply(_zombieId, kittyDna, "kitty");
  // }

  // function setKittyContractAddress(address _address) external onlyOwner {
  //     kittyContract = KittyInterface(_address);
  // }
}
