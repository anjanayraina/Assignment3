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
        swapContract = new SwapContract(tokenA, tokenB, 2 , address(this));
        tokenA.mint(address(0x123), 1000 * (10 ** tokenA.decimals()));
        tokenB.mint(address(0x123), 1000 * (10 ** tokenB.decimals()));
        tokenA.mint(address(swapContract), 1000 * (10 ** tokenA.decimals()));
        tokenB.mint(address(swapContract), 1000 * (10 ** tokenB.decimals()));
        vm.stopPrank();
    }


    function test_balanceOfTokenA() public {
        assertEq(tokenA.balanceOf(address(0x123)), 1000 * (10 ** tokenA.decimals()));
    }

    function test_balanceOfTokenB() public {
        assertEq(tokenB.balanceOf(address(0x123)), 1000 * (10 ** tokenA.decimals()));
    }

    function test_SwapAForB() public {
        vm.startPrank(address(0x123));
        tokenA.approve(address(swapContract), 100 * (10 ** tokenA.decimals()));
        swapContract.swapAforB(100 * (10 ** tokenA.decimals()));
        assertEq(tokenA.balanceOf(address(0x123)), 900 * (10 ** tokenA.decimals()));
        assertEq(tokenB.balanceOf(address(0x123)), 1200 * (10 ** tokenB.decimals()));
    }

    function test_SwapBForA() public {
        vm.startPrank(address(0x123));
        tokenB.approve(address(swapContract), 100 * (10 ** tokenB.decimals()));
        swapContract.swapBforA(100 * (10 ** tokenB.decimals()));
        assertEq(tokenB.balanceOf(address(0x123)), 900 * (10 ** tokenA.decimals()));
        assertEq(tokenA.balanceOf(address(0x123)), 1050 * (10 ** tokenB.decimals()));
    }

    function test_WithdrawFunction() public {
        vm.startPrank(address(this));
        uint256 balanceBefore = tokenA.balanceOf(address(this));
        swapContract.withdrawToken(tokenA, 1000);
        assertEq(tokenA.balanceOf(address(this)), balanceBefore + 1000);
    }
}
