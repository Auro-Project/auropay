import 'package:web3dart/web3dart.dart';
import 'package:ethereum_address/ethereum_address.dart';

final client = Web3Client('https://mainnet.infura.io/v3/your_infura_project_id', Client());

const contractABI = [
  // Specify the contract's functions and variables
  // Example: ['function transfer(address to, uint256 value) public']
];
const contractAddress = EthereumAddress.fromHex('0xabcdef1234567890');

final contract = DeployedContract(ContractAbi.fromJson(contractABI, 'Aurocoin'), contractAddress);

final generateAurocoinFunction = contract.function('generateAurocoin');
final transaction = await client.sendTransaction(
contract: contract,
function: generateAurocoinFunction,
from: EthereumAddress.fromHex('0xsender_address'),
gasPrice: EtherAmount.inWei(BigInt.one),
maxGas: 100000,
// Specify any additional function parameters if required
);
