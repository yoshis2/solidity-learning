# イーサリアムVM（EVM）のオペコードと命令リファレンス

このリファレンスは、[yellow paper](http://gavwood.com/paper.pdf)、 [stack exchange](https://ethereum.stackexchange.com/questions/119/what-opcodes-are-available-for-the-ethereum-evm)、[solidity source](https://github.com/ethereum/solidity/blob/c61610302aa2bfa029715b534719d25fe3949059/libevmasm/Instruction.h#L40)、 [parity source](https://github.com/paritytech/parity/blob/d365281cce919edc42340c97ce212f49d9447d2d/ethcore/evm/src/instructions.rs#L311)、[evm-opcode-gas-costs](https://github.com/djrtwo/evm-opcode-gas-costs/blob/master/opcode-gas-costs_EIP-150_revision-1e18248_2017-04-12.csv)、[Manticore](https://github.com/trailofbits/manticore/blob/c6f457d72e1164c4c8c6d0256fe9b8b765d2cb24/manticore/platforms/evm.py#L590)からのEVMオペコード情報を統合したものです。

新しい課題や貢献を歓迎し、Trail of Bitsからの報奨金でカバーします。[Empire Hacking Slack](https://empireslacking.herokuapp.com)の#ethereumでEthereumセキュリティツールの開発について議論しましょう。

## Notes

EVMの「ワード」のサイズは256ビットである。

ガス情報は現在作成中です。ガス欄にアスタリスクがある場合、基本料金が表示されるが、オペコードの引数によって異なる場合がある。

## Table

| Opcode | Name | Description | Extra Info | Gas |
| --- | --- | --- | --- | --- |
| `0x00` | STOP | 実行停止 | - | 0 |
| `0x01` | ADD | 加算操作 | - | 3 |
| `0x02` | MUL | 乗算演算 | - | 5 |
| `0x03` | SUB | 減算演算 | - | 3 |
| `0x04` | DIV | 整数の除算演算 | - | 5 |
| `0x05` | SDIV | 符号付き整数除算演算（切り捨て） | - | 5 |
| `0x06` | MOD | モジュロ剰余演算| - | 5 |
| `0x07` | SMOD | 符号付きモジュロ剰余演算	 | - | 5 |
| `0x08` | ADDMOD | モジュロ加算演算 | - | 8 |
| `0x09` | MULMOD | モジュロ乗算演算 | - | 8 |
| `0x0a` | EXP | 指数演算 | - | 10* |
| `0x0b` | SIGNEXTEND | 2の補数符号付き整数の長さを伸ばす | - | 5 |
| `0x0c` - `0x0f` | Unused | 未使用 | - |
| `0x10` | LT | 未満比較 | - | 3 |
| `0x11` | GT | 大小比較 | - | 3 |
| `0x12` | SLT | 署名入り小計比較 | - | 3 |
| `0x13` | SGT | 符号付き大小比較 | - | 3 |
| `0x14` | EQ | 平等性の比較 | - | 3 |
| `0x15` | ISZERO | 単純なnot演算子 | - | 3 |
| `0x16` | AND | ビットごとのAND演算 | - | 3 |
| `0x17` | OR | ビット毎OR演算 | - | 3 |
| `0x18` | XOR | ビットごとのXOR演算 | - | 3 |
| `0x19` | NOT | ビット単位のNOT演算 | - | 3 |
| `0x1a` | BYTE | ワードから1バイトを取り出す | - | 3 |
| `0x1b` | SHL | 左シフト | [EIP145](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-145.md) | 3 |
| `0x1c` | SHR | 右論理シフト | [EIP145](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-145.md) | 3 |
| `0x1d` | SAR | 算術右シフト | [EIP145](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-145.md) | 3 |
| `0x20` | KECCAK256 | Compute Keccak-256 hash | - | 30* |
| `0x21` - `0x2f`| Unused | 未使用 |
| `0x30` | ADDRESS | 現在実行中のアカウントのアドレスを取得 | - | 2 |
| `0x31` | BALANCE | 指定された口座の残高を取得する | - | 700 |
| `0x32` | ORIGIN | 実行発信アドレスの取得 | - | 2 |
| `0x33` | CALLER | 発信者アドレスの取得 | - | 2 |
| `0x34` | CALLVALUE | この実行を担当した命令/トランザクションによって預託された値を取得する。 | - | 2 |
| `0x35` | CALLDATALOAD | 現在の環境の入力データを取得する | - | 3 |
| `0x36` | CALLDATASIZE | 現在の環境における入力データのサイズを取得する | - | 2* |
| `0x37` | CALLDATACOPY | 現環境の入力データをメモリにコピーする | - | 3 |
| `0x38` | CODESIZE | 現在の環境で実行されているコードのサイズを取得する | - | 2 |
| `0x39` | CODECOPY | 現在の環境で実行されているコードをメモリにコピーする | - | 3* |
| `0x3a` | GASPRICE | 現在の環境におけるガス料金 | - | 2 |
| `0x3b` | EXTCODESIZE | アカウント・コードのサイズを取得する | - | 700 |
| `0x3c` | EXTCODECOPY | アカウントのコードをメモリーにコピーする | - | 700* |
| `0x3d` | RETURNDATASIZE | リターン・データ・バッファのサイズをスタックにプッシュする。 | [EIP 211](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-211.md) | 2 |
| `0x3e` | RETURNDATACOPY | リターン・データ・バッファからメモリにデータをコピーする。 | [EIP 211](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-211.md) | 3 |
| `0x3f` | EXTCODEHASH | 契約コードの keccak256 ハッシュを返します。 | [EIP 1052](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1052.md) | 700 |
| `0x40` | BLOCKHASH | 最新の256個の完全なブロックの1つのハッシュを取得する。 | - | 20 |
| `0x41` | COINBASE | ブロックの受益者アドレスを取得 | - | 2 |
| `0x42` | TIMESTAMP | ブロックのタイムスタンプを取得する | - | 2 |
| `0x43` | NUMBER | ブロック番号の取得 | - | 2 |
| `0x44` | DIFFICULTY | ブロックの難易度を取得する | - | 2 |
| `0x45` | GASLIMIT | ブロックのガス制限を取得 | - | 2 |
| `0x46` | CHAINID | 現在のチェーンのEIP-155一意な識別子を返します。 | [EIP 1344](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1344.md) | 2 |
| `0x47` - `0x4f` | Unused | - |
| `0x48` | BASEFEE | 現在実行中のブロックの基本料金の値を返す。 | [EIP 3198](https://eips.ethereum.org/EIPS/eip-3198) | 2 |
| `0x50` | POP | スタックから単語を取り除く | - | 2 |
| `0x51` | MLOAD | メモリからワードをロードする | - | 3* |
| `0x52` | MSTORE | 単語をメモリーに保存 | - | 3* |
| `0x53` | MSTORE8 | バイトをメモリに保存 | - | 3 |
| `0x54` | SLOAD | ストレージからワードをロードする | - | 800 |
| `0x55` | SSTORE | 単語をストレージに保存 | - | 20000** |
| `0x56` | JUMP | プログラムカウンターの変更 | - | 8 |
| `0x57` | JUMPI | 条件付きでプログラム・カウンターを変更する | - | 10 |
| `0x58` | GETPC | インクリメント前のプログラム・カウンターの値を取得する。 | - | 2 |
| `0x59` | MSIZE | アクティブ・メモリのサイズをバイト単位で取得 | - | 2 |
| `0x5a` | GAS | 利用可能なガスの量を取得し、この指示のコストに対応する削減を含む | - | 2 |
| `0x5b` | JUMPDEST | 有効なジャンプ先をマークする | - | 1 |
| `0x5c` - `0x5f` | Unused | - |
| `0x60` | PUSH1 | 1バイトのアイテムをスタックに置く | - | 3 |
| `0x61` | PUSH2 | 2バイトのアイテムをスタックに置く | - | 3 |
| `0x62` | PUSH3 | 3バイトのアイテムをスタックに置く | - | 3 |
| `0x63` | PUSH4 | 4バイトのアイテムをスタックに置く | - | 3 |
| `0x64` | PUSH5 | 5バイトのアイテムをスタックに置く | - | 3 |
| `0x65` | PUSH6 | 6バイトのアイテムをスタックに置く | - | 3 |
| `0x66` | PUSH7 | 7バイトのアイテムをスタックに置く | - | 3 |
| `0x67` | PUSH8 | 8バイトのアイテムをスタックに置く | - | 3 |
| `0x68` | PUSH9 | 9バイトのアイテムをスタックに置く | - | 3 |
| `0x69` | PUSH10 | 10バイトのアイテムをスタックに置く | - | 3 |
| `0x6a` | PUSH11 | 11バイトのアイテムをスタックに置く | - | 3 |
| `0x6b` | PUSH12 | 12バイトのアイテムをスタックに置く | - | 3 |
| `0x6c` | PUSH13 | 13バイトのアイテムをスタックに置く | - | 3 |
| `0x6d` | PUSH14 | 14バイトのアイテムをスタックに置く | - | 3 |
| `0x6e` | PUSH15 | 15バイトのアイテムをスタックに置く | - | 3 |
| `0x6f` | PUSH16 | 16バイトのアイテムをスタックに置く | - | 3 |
| `0x70` | PUSH17 | 17バイトのアイテムをスタックに置く | - | 3 |
| `0x71` | PUSH18 | 18バイトのアイテムをスタックに置く | - | 3 |
| `0x72` | PUSH19 | 19バイトのアイテムをスタックに置く | - | 3 |
| `0x73` | PUSH20 | 20バイトのアイテムをスタックに置く | - | 3 |
| `0x74` | PUSH21 | 21バイトのアイテムをスタックに置く | - | 3 |
| `0x75` | PUSH22 | 22バイトのアイテムをスタックに置く | - | 3 |
| `0x76` | PUSH23 | 23バイトのアイテムをスタックに置く | - | 3 |
| `0x77` | PUSH24 | 24バイトのアイテムをスタックに置く | - | 3 |
| `0x78` | PUSH25 | 25バイトのアイテムをスタックに置く | - | 3 |
| `0x79` | PUSH26 | 26バイトのアイテムをスタックに置く | - | 3 |
| `0x7a` | PUSH27 | 27バイトのアイテムをスタックに置く | - | 3 |
| `0x7b` | PUSH28 | 28バイトのアイテムをスタックに置く | - | 3 |
| `0x7c` | PUSH29 | 29バイトのアイテムをスタックに置く | - | 3 |
| `0x7d` | PUSH30 | 30バイトのアイテムをスタックに置く | - | 3 |
| `0x7e` | PUSH31 | 31バイトのアイテムをスタックに置く | - | 3 |
| `0x7f` | PUSH32 | 32バイト（フルワード）のアイテムをスタックに置く	 | - |  3 |
| `0x80` | DUP1 | 第1スタック項目の複製 | - |  3 |
| `0x81` | DUP2 | 第2スタック項目の複製 | - | 3 |
| `0x82` | DUP3 | 第3スタック項目の複製 | - | 3 |
| `0x83` | DUP4 | 第4スタック項目の複製 | - | 3 |
| `0x84` | DUP5 | 第5スタック項目の複製 | - | 3 |
| `0x85` | DUP6 | 第6スタック項目の複製 | - | 3 |
| `0x86` | DUP7 | 第7スタック項目の複製 | - | 3 |
| `0x87` | DUP8 | 第8スタック項目の複製 | - | 3 |
| `0x88` | DUP9 | 第9スタック項目の複製 | - | 3 |
| `0x89` | DUP10 | 第10スタック項目の複製 | - | 3 |
| `0x8a` | DUP11 | 第11スタック項目の複製 | - | 3 |
| `0x8b` | DUP12 | 第12スタック項目の複製 | - | 3 |
| `0x8c` | DUP13 | 第13スタック項目の複製 | - | 3 |
| `0x8d` | DUP14 | 第14スタック項目の複製 | - | 3 |
| `0x8e` | DUP15 | 第15スタック項目の複製 | - | 3 |
| `0x8f` | DUP16 | 第16スタック項目の複製 | - | 3 |
| `0x90` | SWAP1 | 第1スタックと第2スタックのアイテムを交換 | - | 3 |
| `0x91` | SWAP2 | 第1スタックと第3スタックのアイテムを交換 | - | 3 |
| `0x92` | SWAP3 | 第1スタックと第4スタックのアイテムを交換 | - | 3 |
| `0x93` | SWAP4 | 第1スタックと第5スタックのアイテムを交換 | - | 3 |
| `0x94` | SWAP5 | 第1スタックと第6スタックのアイテムを交換 | - | 3 |
| `0x95` | SWAP6 | 第1スタックと第7スタックのアイテムを交換 | - | 3 |
| `0x96` | SWAP7 | 第1スタックと第8スタックのアイテムを交換 | - | 3 |
| `0x97` | SWAP8 | 第1スタックと第9スタックのアイテムを交換 | - | 3 |
| `0x98` | SWAP9 | 第1スタックと第10スタックのアイテムを交換 | - | 3 |
| `0x99` | SWAP10 | 第1スタックと第11スタックのアイテムを交換 | - | 3 |
| `0x9a` | SWAP11 | 第1スタックと第12スタックのアイテムを交換 | - | 3 |
| `0x9b` | SWAP12 | 第1スタックと第13スタックのアイテムを交換 | - | 3 |
| `0x9c` | SWAP13 | 第1スタックと第14スタックのアイテムを交換 | - | 3 |
| `0x9d` | SWAP14 | 第1スタックと第15スタックのアイテムを交換 | - | 3 |
| `0x9e` | SWAP15 | 第1スタックと第16スタックのアイテムを交換 | - | 3 |
| `0x9f` | SWAP16 | 第1スタックと第17スタックのアイテムを交換 | - | 3 |
| `0xa0` | LOG0 | トピックがないログレコードを追加する | - | 375 |
| `0xa1` | LOG1 | 1つのトピックでログレコードを追加する | - | 750 |
| `0xa2` | LOG2 | 2つのトピックでログレコードを追加する | - | 1125 |
| `0xa3` | LOG3 | 3つのトピックでログレコードを追加する | - | 1500 |
| `0xa4` | LOG4 | 4つのトピックでログレコードを追加する | - | 1875 |
| `0xa5` - `0xaf` | Unused | - |
| `0xb0` | JUMPTO | 暫定 [libevmasm has different numbers](https://github.com/ethereum/solidity/blob/c61610302aa2bfa029715b534719d25fe3949059/libevmasm/Instruction.h#L176)| [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb1` | JUMPIF | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb2` | JUMPSUB | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb4` | JUMPSUBV | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb5` | BEGINSUB | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb6` | BEGINDATA | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb8` | RETURNSUB | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xb9` | PUTLOCAL | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xba` | GETLOCAL | 暫定 | [EIP 615](https://github.com/ethereum/EIPs/blob/606405b5ab7aa28d8191958504e8aad4649666c9/EIPS/eip-615.md) |
| `0xbb` - `0xe0` | Unused | - |
| `0xe1` | SLOADBYTES | pyethereum でのみ参照 | - | - |
| `0xe2` | SSTOREBYTES | pyethereum でのみ参照 | - | - |
| `0xe3` | SSIZE | pyethereum でのみ参照 | - | - |
| `0xe4` - `0xef` | Unused | - |
| `0xf0` | CREATE | 関連コードで新しいアカウントを作成する | - | 32000 |
| `0xf1` | CALL | 口座へのメッセージ・コール | - | Complicated |
| `0xf2` | CALLCODE | この口座にメッセージ・コールし、代替口座のコードを伝える。 | - | Complicated |
| `0xf3` | RETURN | 出力データを返す実行停止 | - | 0 |
| `0xf4` | DELEGATECALL | このアカウントに別のアカウント・コードでメッセージ・コールするが、このアカウントに別のアカウント・コードで持続する。 | - | Complicated |
| `0xf5` | CREATE2 | 新しいアカウントを作成し、作成アドレスを `sha3(sender + sha3(init code)) % 2**160` | - |
| `0xf6` - `0xf9` | Unused | - | - |
| `0xfa` | STATICCALL | CALLに似ているが、状態を変更しない | - | 40 |
| `0xfb` | Unused | - | - |
| `0xfc` | TXEXECGAS | yellow paper にはない FIXME | - | - |
| `0xfd` | REVERT | 提供されたすべてのガスを消費することなく、理由を提供することなく、実行を停止し、状態の変更を戻す | - | 0 |
| `0xfe` | INVALID | 指定無効命令 | - | 0 |
| `0xff` | SELFDESTRUCT | 実行を停止し、後で削除するためにアカウントを登録する。 | - | 5000* | 

## Instruction Details

### ADD

スタックから2つの単語を取り出し、それらを加算し、結果をスタックにプッシュする。

疑似コード: `push(s[0]+s[1])`

### PUSHX

次のXバイトがPCから読み出され、1ワードにまとめられ、このワードがスタックにプッシュされる。

### CALL
