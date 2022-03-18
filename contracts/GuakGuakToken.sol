pragma solidity >=0.6.0 <0.9.0;
 
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
 
contract GuakGuakToken is ERC1155, Ownable 
{
    using SafeMath for uint256;
 
    uint256 public immutable unitPrice;
    uint256 public immutable maxSupply;
    uint256 public totalSupply;
    bool public isSaleActive;
    
    constructor() public ERC1155("GuakGuak") 
    {
        unitPrice = 0.05 * 10 ** 18;
        maxSupply = 10;
        totalSupply = 1;
    }
 
    function flipSaleState() public onlyOwner {
        isSaleActive = !isSaleActive;
    }
 
    function setURI(string memory URI) public onlyOwner {
        _setURI(URI);
    }
 
   function reserve() public onlyOwner {   
        require(totalSupply < 10);
        uint256 mintIndex = totalSupply;
        if (mintIndex < maxSupply) {
            _mint(msg.sender, mintIndex, 1, "");
            totalSupply ++;
        }
    }
 
    function mint(uint256 count) public payable {
        require(isSaleActive, "Sale is not active");
        require(totalSupply+1 <= maxSupply, "Purchase would exceed max supply of GuakGuak");
        require(unitPrice == msg.value, "Ether value is too small to buy the GuakGuak");
        require(count > 0, "GuakGuak count should > 0");
        
        payable(owner()).transfer(msg.value);
 
        uint256 mintIndex = totalSupply;
        if (mintIndex < maxSupply) {
            _mint(msg.sender, mintIndex, count, "");
            totalSupply ++;
        }
    }
}