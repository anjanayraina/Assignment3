pragma solidity 0.8.23;

import "forge-std/Test.sol";
import "../src/SwapContract.sol";
import "../src/Token/Token.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SwapContractTest is Test {
    SwapContract public swapContract;
    Token public tokenA;
    Token public tokenB;

    function setUp() public {
        vm.startPrank(address(this));
        tokenA = new Token(address(this) ,"TokenA", "TA");
        tokenB = new Token(address(this)  , "TokenB", "TB");
        swapContract = new SwapContract(tokenA, tokenB, 1);
        tokenA.mint(address(this), 1000*(10**tokenA.decimals()));
        tokenB.mint(address(this), 1000*(10**tokenB.decimals()));
        vm.stopPrank();
    }
}
