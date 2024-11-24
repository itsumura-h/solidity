NFT
===

メタデータの構造
```json
{
  "name": "Your Collection #1",
  "description": "Remember to replace this description",
  "image": "ipfs://bafybeih………/1.png",
  "dna": "6ff01f8cc7967a6034e6b56d962c1e5149455c8c",
  "edition": 1,
  "date": 1655096584532,
  "attributes": [
    {
      "trait_type": "background",
      "value": "red"
    },
    {
      "trait_type": "object",
      "value": "blue_circle"
    },
    {
      "trait_type": "frame",
      "value": "frame"
    }
  ]
}
```

| データ名 | 説明 |
| --- | --- |
| image | NFTの画像の場所を表すURL。httpやipfsで指定する。 |
| external_url | 画像の下に表示されるリンクのURL。NFTに関連する情報を別ページで表示できるようになる。 |
| description | NFTに関する説明文。マークダウン記法に対応している。 |
| name | NFT単体の名前。 |
| attributes | NFTが持つ属性および特徴。複数の項目とともに記述する。 |
| background_color | NFTの背景色。6文字の16進数で色を指定する。例）FF0000（赤）、008080（青緑） |
| animation_url | NFTのアニメーション画像の場所を表すURL。MP4などの動画ファイルや、MP3などの音楽ファイルに対応している。 |
| youtube_url | YouTube動画のリンクURL。 |

attributesの構造

| パラメータ名 | 説明 |
| --- | --- |
| display_type | データの表示形式。未設定時は、プロパティ欄にデータを表示する。<br>※OpenSeaで利用できるパラメータ<br>・boost_number<br>・boost_percentage<br>・number<br>・date |
| trait_type | 項目の名前。 |
| value | 項目の値。 |
| max_value | 値の最大値。一部の表示形式で使用できる。 |



## メタデータの作り方

```solidity
contract Nft is ERC721 {
  // nameとsymbolを設定する
  constructor(string memory name, string memory symbol) ERC721(name, symbol) {}

  // メタデータのURLを設定する
  function _baseURI() internal pure override returns (string memory) {
    return "https://example.com/metadata/";
  }

  // 素の関数では後ろにjsonは付かない
  // 後ろに.jsonを付けるようにoverrideして定義する
  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    require(_exists(tokenId), "Nishikigoi: URI query for nonexistent token");

    string memory baseURI = _baseURI();

    return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
  }
}
```

_baseURIを設定すると、`tokenURI`のメソッドを実行したときに、`_baseURI`に`tokenId`を追加したURLを返すようになる。

```solidity
// コントラクトをデプロイする
address owner = makeAddr("owner");
vm.prank(owner);
NFT nft = new NFT("name", "symbol");

address user = makeAddr("user");
vm.prank(user);
// ミントする
nft.mint(user, 1);

// メタデータのURLを取得する
string memory uri = nft.tokenURI(1);
console.log(uri);
// >  https://example.com/metadata/1.json
```

## 実装例
ニシキゴイ

https://etherscan.io/address/0xf16a5b64f5a774c24218a83f6fb2c7700fb6469a#readContract

```json
// 20241113140523
// https://metadata.nishikigoinft.com/0xf16a5b64f5a774c24218a83f6fb2c7700fb6469a/1.json

{
  "name": "Colored Carp #1",
  "description": "The curved lines representing colored carp are placed at equal spaces with the colors and directions that are randomly chosen. The ellipses are also randomly drawn out throughout the screen, and their direction keeps changing with purlin noise to create a force field.\n\nCid: [QmfZpu2JnLgwep5mzo1NbLtrmVZiqKucsBmt776FuwZPD4](https://ipfs.io/ipfs/QmfZpu2JnLgwep5mzo1NbLtrmVZiqKucsBmt776FuwZPD4?seed=1#)\n\nLicense: [Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)](https://creativecommons.org/licenses/by-nc-sa/3.0/)\n\nArtist: Okazz\n\nArtist SNS: [Twitter](https://twitter.com/okazz_), [OpenProcessing](https://openprocessing.org/user/128718), [Foundation](https://foundation.app/@okazz_)\n\nLibrary: [p5.js](https://p5js.org/)",
  "image": "https://ipfs.io/ipfs/QmXn9FvD3Gpboqy1er3WqnoyHWakJWBwTyUh4shAXpAXiM",
  "external_url": "https://ipfs.io/ipfs/QmfZpu2JnLgwep5mzo1NbLtrmVZiqKucsBmt776FuwZPD4?seed=1#",
  "animation_url": "https://ipfs.io/ipfs/QmfZpu2JnLgwep5mzo1NbLtrmVZiqKucsBmt776FuwZPD4?seed=1#",
  "origin_cid": "QmfZpu2JnLgwep5mzo1NbLtrmVZiqKucsBmt776FuwZPD4",
  "attributes": [
    {
      "trait_type": "Artist",
      "value": "Okazz"  
    },
    {
      "trait_type": "License",
      "value": "Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)"
    },
    {
      "trait_type": "Library",
      "value": "p5.js"
    }
  ],
  "license_url": "https://creativecommons.org/licenses/by-nc-sa/3.0/"
}
```
