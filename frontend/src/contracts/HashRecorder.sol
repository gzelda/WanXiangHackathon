pragma solidity >=0.4.22 <0.6.0;

contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
  
  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  /*@CTK owner_set_on_success
    @pre __reverted == false -> __post.owner == owner
   */
  /* CertiK Smart Labelling, for more details visit: https://certik.org */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  /*@CTK transferOwnership
    @post __reverted == false -> (msg.sender == owner -> __post.owner == newOwner)
    @post (owner != msg.sender) -> (__reverted == true)
    @post (newOwner == address(0)) -> (__reverted == true)
   */
  /* CertiK Smart Labelling, for more details visit: https://certik.org */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}


contract HashRecorder is Ownable {

    string[] public records;
    uint public recordNum;

    event RecordHash(uint indexed index, string recordedHash);


    constructor() public {
        recordNum = 0;
    }

    /// Record hash
    function recordHash(string memory newHash) public onlyOwner returns (uint) {
        recordNum = records.push(newHash);
        emit RecordHash(recordNum - 1, newHash);
        return recordNum - 1;
    }

}
